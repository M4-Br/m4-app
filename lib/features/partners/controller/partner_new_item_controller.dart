import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dialogs.dart'; // Import necessário para o Dialog
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/partners/model/partners_model.dart';
import 'package:app_flutter_miban4/features/partners/repository/partners_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PartnerNewItemController extends BaseController {
  final PartnerManagementRepository _repository = PartnerManagementRepository();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final marketValueController = TextEditingController();
  final partnerValueController = TextEditingController();

  final newCategoryController = TextEditingController();
  final RxBool isCreatingCategory = false.obs;

  final RxList<PartnerCategory> availableCategories = <PartnerCategory>[].obs;
  final Rxn<PartnerCategory> selectedCategory = Rxn<PartnerCategory>();

  final RxDouble calculatedDiscount = 0.0.obs;

  final PartnerCategory _createNewOption = PartnerCategory(
      categoryName: '+ Criar nova categoria', items: [], id: -1);

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>?;

    if (args != null && args['categories'] != null) {
      availableCategories.assignAll([
        ...args['categories'],
        _createNewOption,
      ]);
    } else {
      availableCategories.add(_createNewOption);
    }

    marketValueController.addListener(_calculateDiscount);
    partnerValueController.addListener(_calculateDiscount);
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    marketValueController.dispose();
    partnerValueController.dispose();
    newCategoryController.dispose();
    super.onClose();
  }

  void onCategoryChanged(PartnerCategory? val) {
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
    final partner = _parseCurrency(partnerValueController.text);

    if (market > 0 && partner > 0 && market >= partner) {
      calculatedDiscount.value = market - partner;
    } else {
      calculatedDiscount.value = 0.0;
    }
  }

  Future<void> confirmRegistration() async {
    if (nameController.text.isEmpty ||
        marketValueController.text.isEmpty ||
        partnerValueController.text.isEmpty) {
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
        confirmText: 'CADASTRAR',
        loading: isLoading,
        onConfirm: () async {
          await _processSaving();
        },
      );
    } else {
      // Tem desconto, salva direto
      await _processSaving();
    }
  }

  Future<void> _processSaving() async {
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
      final partner = _parseCurrency(partnerValueController.text);

      final newItem = PartnerItem(
        id: '',
        categoryId: categoryId,
        userId: userRx.userId.toString(),
        name: nameController.text,
        description: descriptionController.text,
        marketValue: market,
        partnerValue: partner,
        discount: calculatedDiscount.value,
      );

      await _repository.createProduct(newItem, categoryId);

      ShowToaster.toasterInfo(message: 'Produto cadastrado com sucesso!');

      if (Get.isDialogOpen ?? false) Get.back();
      Get.back();
    }, message: 'Erro ao cadastrar o produto');

    isLoading.value = false;
  }
}
