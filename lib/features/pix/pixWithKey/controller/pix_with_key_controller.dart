import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/pix/pixWithKey/repository/pix_with_key_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PixWithKeyController extends BaseController {
  final keyController = TextEditingController();

  final selectedType = RxnString();
  final isButtonEnabled = false.obs;

  final Map<String, String> keyTypes = {
    'EVP': 'Chave Aleatória',
    'EMAIL': 'Email',
    'PHONE': 'Celular',
    'DOCUMENT': 'CPF/CNPJ',
  };

  @override
  void onInit() {
    super.onInit();
    keyController.addListener(_validateInput);
    ever(selectedType, (_) => _validateInput());
  }

  @override
  void onClose() {
    keyController.dispose();
    super.onClose();
  }

  void onTypeChanged(String? newValue) {
    selectedType.value = newValue;
    keyController.clear();
  }

  void _validateInput() {
    final text = keyController.text.trim();
    final type = selectedType.value;

    if (type == null || text.isEmpty) {
      isButtonEnabled.value = false;
      return;
    }

    bool isValid = false;

    switch (type) {
      case 'DOCUMENT': // CPF/CNPJ
      case 'PHONE': // Celular
        isValid = text.replaceAll(RegExp(r'[^0-9]'), '').length >= 11;
        break;
      case 'EMAIL':
        isValid = GetUtils.isEmail(text);
        break;
      case 'EVP':
        isValid = text.length > 10;
        break;
      default:
        isValid = false;
    }

    isButtonEnabled.value = isValid;
  }

  Color get buttonColor => isButtonEnabled.value ? secondaryColor : Colors.grey;

  Future<void> searchKey() async {
    if (!isButtonEnabled.value) return;
    FocusManager.instance.primaryFocus?.unfocus();

    await executeSafe(() async {
      final key = keyController.text.trim();
      final type = selectedType.value!;

      final keyValidated = await PixWithKeyRepository().validateKey(key);

      if (keyValidated.success == true) {
        Get.toNamed(AppRoutes.pixTransfer,
            arguments: {'key': keyValidated, 'type': type});
      }
    });
  }

  void backToHome() {
    Get.back();
  }
}
