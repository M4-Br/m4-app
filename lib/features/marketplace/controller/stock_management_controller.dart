import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dialogs.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/marketplace/model/partners_model.dart';
import 'package:app_flutter_miban4/features/marketplace/repository/marketplace_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockManagementController extends BaseController {
  final MarketplaceManagementRepository _repository =
      MarketplaceManagementRepository();

  // --- ESTADOS DA LISTA E BUSCA ---
  final RxList<MarketplaceItem> myProducts = <MarketplaceItem>[].obs;
  final RxList<MarketplaceItem> filteredProducts = <MarketplaceItem>[].obs;
  final searchController = TextEditingController();

  // --- ESTADOS DO FORMULÁRIO (CRIAR/EDITAR) ---
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final marketValueController = TextEditingController();
  final marketplaceValueController = TextEditingController();
  final newCategoryController = TextEditingController();

  final RxBool isCreatingCategory = false.obs;
  final RxList<MarketplaceCategory> availableCategories =
      <MarketplaceCategory>[].obs;
  final Rxn<MarketplaceCategory> selectedCategory = Rxn<MarketplaceCategory>();
  final RxDouble calculatedDiscount = 0.0.obs;

  final MarketplaceCategory _createNewOption = MarketplaceCategory(
      categoryName: '+ Criar nova categoria', items: [], id: -1);

  // --- INDICADORES ---
  int get totalProducts => myProducts.length;

  int get lowStockCount {
    if (myProducts.isEmpty) return 0;
    // TODO: Adicionar lógica real de estoque baixo quando o Model tiver 'quantity' e 'minQuantity'
    // return myProducts.where((p) => p.quantity <= p.minQuantity).length;
    return 0;
  }

  double get totalStockValue =>
      myProducts.fold(0.0, (sum, item) => sum + item.marketValue);

  @override
  void onInit() {
    super.onInit();
    marketValueController.addListener(_calculateDiscount);
    marketplaceValueController.addListener(_calculateDiscount);
    fetchMyProducts();
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    marketValueController.dispose();
    marketplaceValueController.dispose();
    newCategoryController.dispose();
    searchController.dispose();
    super.onClose();
  }

  // --- CARREGAMENTO DE DADOS (SUA LÓGICA ORIGINAL) ---
  Future<void> fetchMyProducts() async {
    await executeSafe(() async {
      isLoading.value = true;
      myProducts.clear();
      availableCategories.clear();

      final results = await Future.wait([
        _repository.getCategories(),
        _repository.getProducts(),
      ]);

      availableCategories.assignAll(
          [...results[0] as List<MarketplaceCategory>, _createNewOption]);

      final allProducts = results[1] as List<MarketplaceItem>;

      final myOwnProducts = allProducts
          .where((p) => p.userId == userRx.userId.toString())
          .toList();

      myProducts.assignAll(myOwnProducts);
      filteredProducts
          .assignAll(myOwnProducts); // Alimenta a lista da busca inicial
    }, message: 'Erro ao carregar seus dados');

    isLoading.value = false;
  }

  // --- LÓGICA DE BUSCA ---
  void filterProducts(String query) {
    if (query.isEmpty) {
      filteredProducts.assignAll(myProducts);
    } else {
      query = query.toLowerCase();
      filteredProducts.assignAll(myProducts.where((p) {
        return p.name.toLowerCase().contains(query) ||
            p.id.toLowerCase().contains(query); // SKU/ID
      }).toList());
    }
  }

  // --- LÓGICA DO FORMULÁRIO (CRIAR/EDITAR) ---
  void prepareForm([MarketplaceItem? item]) {
    if (item != null) {
      // É uma edição
      nameController.text = item.name;
      descriptionController.text = item.description;
      marketValueController.text =
          item.marketValue.toStringAsFixed(2).replaceAll('.', ',');
      marketplaceValueController.text =
          item.marketplaceValue.toStringAsFixed(2).replaceAll('.', ',');

      selectedCategory.value =
          availableCategories.firstWhereOrNull((c) => c.id == item.categoryId);
      isCreatingCategory.value = false;
      calculatedDiscount.value = item.discount;
    } else {
      // É um novo
      nameController.clear();
      descriptionController.clear();
      marketValueController.clear();
      marketplaceValueController.clear();
      newCategoryController.clear();
      selectedCategory.value = null;
      isCreatingCategory.value = false;
      calculatedDiscount.value = 0.0;
    }
  }

  void onCategoryChanged(MarketplaceCategory? val) {
    selectedCategory.value = val;
    isCreatingCategory.value =
        val?.categoryName == _createNewOption.categoryName;
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

  void _calculateDiscount() {
    final market = _parseCurrency(marketValueController.text);
    final marketplace = _parseCurrency(marketplaceValueController.text);

    if (market > 0 && marketplace > 0 && market >= marketplace) {
      calculatedDiscount.value = market - marketplace;
    } else {
      calculatedDiscount.value = 0.0;
    }
  }

  Future<void> saveProduct({String? existingId}) async {
    if (nameController.text.isEmpty ||
        marketValueController.text.isEmpty ||
        marketplaceValueController.text.isEmpty) {
      ShowToaster.toasterInfo(
          message: 'Preencha todos os valores corretamente', isError: true);
      return;
    }

    if (selectedCategory.value == null) {
      ShowToaster.toasterInfo(
          message: 'Selecione uma categoria', isError: true);
      return;
    }

    if (isCreatingCategory.value && newCategoryController.text.trim().isEmpty) {
      ShowToaster.toasterInfo(
          message: 'Digite o nome da nova categoria', isError: true);
      return;
    }

    if (calculatedDiscount.value <= 0) {
      CustomDialogs.showConfirmationDialog(
        title: 'Atenção',
        content:
            'Você está cadastrando um produto parceiro sem desconto. Deseja prosseguir mesmo assim?',
        confirmText: existingId == null ? 'CADASTRAR' : 'ATUALIZAR',
        loading: isLoading,
        onConfirm: () async {
          Get.back(); // 1. Fecha o Dialog de Confirmação primeiro
          await _processSaving(existingId); // 2. Segue com o salvamento
        },
      );
    } else {
      await _processSaving(existingId);
    }
  }

  Future<void> _processSaving(String? existingId) async {
    await executeSafe(() async {
      isLoading.value = true;
      int categoryId = 1;

      if (isCreatingCategory.value) {
        await _repository.createCategory(newCategoryController.text.trim());
        final list = await _repository.getCategories();
        final cat = list.firstWhere(
          (c) => c.categoryName == newCategoryController.text.trim(),
          orElse: () => list.first,
        );
        categoryId = cat.id;
      } else {
        categoryId = selectedCategory.value!.id;
      }

      final market = _parseCurrency(marketValueController.text);
      final marketplace = _parseCurrency(marketplaceValueController.text);

      final itemToSave = MarketplaceItem(
        id: existingId ?? '',
        categoryId: categoryId,
        userId: userRx.userId.toString(),
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        marketValue: market,
        marketplaceValue: marketplace,
        discount: calculatedDiscount.value,
      );

      if (existingId != null) {
        await _repository.updateProduct(itemToSave);
      } else {
        await _repository.createProduct(itemToSave, categoryId);
      }

      ShowToaster.toasterInfo(
          message: existingId == null
              ? 'Produto cadastrado com sucesso!'
              : 'Produto atualizado com sucesso!');

      // AJUSTE AQUI: Removemos os Get.back() duplicados.
      // Agora ele dá apenas um back para fechar o Modal do Formulário de Produto.
      Get.back();

      searchController.clear();
      await fetchMyProducts(); // Recarrega a lista fresca da API
    }, message: 'Erro ao salvar o produto');
    isLoading.value = false;
  }

  // --- DELETAR ITEM (SUA LÓGICA ORIGINAL MANTIDA) ---
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

          Get.back(); // Fecha o dialog de confirmação
          ShowToaster.toasterInfo(message: 'Item retirado com sucesso!');

          await fetchMyProducts(); // Atualiza a tela
        }, message: 'Erro ao remover o item');

        isLoading.value = false;
      },
    );
  }
}
