import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dialogs.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/marketplace/model/partners_model.dart';
import 'package:app_flutter_miban4/features/marketplace/repository/marketplace_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarketplaceManagementController extends BaseController {
  final MarketplaceManagementRepository _repository =
      MarketplaceManagementRepository();

  final RxList<MarketplaceItem> myProducts = <MarketplaceItem>[].obs;
  final RxList<MarketplaceCategory> availableCategories =
      <MarketplaceCategory>[].obs;

  final RxString userRegion = 'Maringá'.obs;

  final editNameCtrl = TextEditingController();
  final editDescCtrl = TextEditingController();
  final editMarketCtrl = TextEditingController();
  final editMarketplaceCtrl = TextEditingController();
  final RxDouble editDiscount = 0.0.obs;

  MarketplaceItem? _itemToEdit;

  @override
  void onInit() {
    super.onInit();
    fetchMyProducts();
  }

  @override
  void onClose() {
    editNameCtrl.dispose();
    editDescCtrl.dispose();
    editMarketCtrl.dispose();
    editMarketplaceCtrl.dispose();
    super.onClose();
  }

  Future<void> fetchMyProducts() async {
    await executeSafe(() async {
      isLoading.value = true;
      myProducts.clear();
      availableCategories.clear();

      final results = await Future.wait([
        _repository.getCategories(),
        _repository.getProducts(),
      ]);

      availableCategories.assignAll(results[0] as List<MarketplaceCategory>);

      final allProducts = results[1] as List<MarketplaceItem>;

      final myOwnProducts = allProducts
          .where((p) => p.userId == userRx.userId.toString())
          .toList();

      myProducts.assignAll(myOwnProducts);
    }, message: 'Erro ao carregar seus dados');

    isLoading.value = false;
  }

  void confirmDeletion(MarketplaceItem item) {
    CustomDialogs.showConfirmationDialog(
      title: 'Atenção',
      content: 'Deseja retirar o item ${item.name}?',
      confirmText: 'Retirar',
      loading: isLoading,
      onConfirm: () async {
        await executeSafe(() async {
          isLoading.value = true;

          await _repository.deleteProduct(item.id);
          myProducts.removeWhere((p) => p.id == item.id);

          Get.back();
          ShowToaster.toasterInfo(message: 'Item retirado com sucesso!');
        }, message: 'Erro ao remover o item');

        isLoading.value = false;
      },
    );
  }

  void goToNewItem() {
    Get.toNamed(AppRoutes.marketplaceNewItem, arguments: {
      'categories': availableCategories,
    })?.then((_) {
      fetchMyProducts();
    });
  }

  void prepareEdit(MarketplaceItem item) {
    _itemToEdit = item;

    editNameCtrl.text = item.name;
    editDescCtrl.text = item.description;
    editMarketCtrl.text =
        item.marketValue.toStringAsFixed(2).replaceAll('.', ',');
    editMarketplaceCtrl.text =
        item.marketplaceValue.toStringAsFixed(2).replaceAll('.', ',');
    editDiscount.value = item.discount;

    editMarketCtrl.removeListener(_calcEditDiscount);
    editMarketplaceCtrl.removeListener(_calcEditDiscount);

    editMarketCtrl.addListener(_calcEditDiscount);
    editMarketplaceCtrl.addListener(_calcEditDiscount);
  }

  double _parseCurrency(String text) {
    if (text.isEmpty) return 0.0;
    final rawString = text
        .replaceAll('R\$', '')
        .replaceAll('.', '')
        .replaceAll(',', '.')
        .trim();
    return double.tryParse(rawString) ?? 0.0;
  }

  void _calcEditDiscount() {
    final m = _parseCurrency(editMarketCtrl.text);
    final p = _parseCurrency(editMarketplaceCtrl.text);

    if (m > 0 && p > 0 && m >= p) {
      editDiscount.value = m - p;
    } else {
      editDiscount.value = 0.0;
    }
  }

  Future<void> saveEditedItem() async {
    if (_itemToEdit == null) return;

    if (editNameCtrl.text.isEmpty ||
        editMarketCtrl.text.isEmpty ||
        editMarketplaceCtrl.text.isEmpty) {
      ShowToaster.toasterInfo(
          message: 'Preencha os valores corretamente', isError: true);
      return;
    }

    await executeSafe(() async {
      isLoading.value = true;

      final market = _parseCurrency(editMarketCtrl.text);
      final marketplace = _parseCurrency(editMarketplaceCtrl.text);

      final updatedItem = MarketplaceItem(
        id: _itemToEdit!.id,
        categoryId: _itemToEdit!.categoryId,
        userId: _itemToEdit!.userId,
        name: editNameCtrl.text,
        description: editDescCtrl.text,
        marketValue: market,
        marketplaceValue: marketplace,
        discount: editDiscount.value,
      );

      await _repository.updateProduct(updatedItem);

      ShowToaster.toasterInfo(message: 'Produto atualizado com sucesso!');
      Get.back(); // Fecha o BottomSheet

      await fetchMyProducts();
    }, message: 'Erro ao atualizar o produto');

    isLoading.value = false;
  }
}
