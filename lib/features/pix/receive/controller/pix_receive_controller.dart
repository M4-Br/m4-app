import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/formatters/formatters.dart';
import 'package:app_flutter_miban4/features/pix/keyManager/model/pix_key_response.dart';
import 'package:app_flutter_miban4/features/pix/keyManager/repository/pix_key_manager_repository.dart';
import 'package:app_flutter_miban4/features/pix/receive/model/pix_create_qr_code_request.dart';
import 'package:app_flutter_miban4/features/pix/receive/repository/pix_receive_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PixReceiveController extends BaseController {
  final identifierController = TextEditingController();
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();

  final RxList<String> availableKeys = <String>[].obs;
  final RxnString selectedKey = RxnString();

  @override
  void onInit() {
    super.onInit();
    fetchKeys();
  }

  @override
  void onClose() {
    identifierController.dispose();
    descriptionController.dispose();
    amountController.dispose();
    super.onClose();
  }

  void goToKeyManager() {
    Get.toNamed(AppRoutes.pixKeyManager);
  }

  Future<void> fetchKeys() async {
    await executeSafe(() async {
      final PixKeyResponse result = await PixKeyManagerRepository().fetchKeys();

      _flattenKeys(result);
    });
  }

  void _flattenKeys(PixKeyResponse keys) {
    final List<String> flatList = [];

    for (var phone in keys.phones) {
      flatList.add(phone.key);
    }

    for (var document in keys.documents) {
      final formatted = cpfFormatter.maskText(document.key);
      flatList.add(formatted);
    }

    for (var email in keys.emails) {
      flatList.add(email.key);
    }
    for (var evp in keys.evps) {
      flatList.add(evp.key);
    }

    availableKeys.assignAll(flatList);
  }

  Future<void> generateQrCode() async {
    if (amountController.text.isEmpty && identifierController.text.isEmpty) {
      Get.snackbar('Atenção', 'Preencha o valor ou o identificador',
          backgroundColor: Colors.amber);
      return;
    }

    if (selectedKey.value == null) {
      Get.snackbar('Atenção', 'Selecione uma chave Pix',
          backgroundColor: Colors.amber);
      return;
    }

    await executeSafe(() async {
      String cleanAmount =
          amountController.text.replaceAll(RegExp(r'[^0-9]'), '');

      String keyToSend = selectedKey.value!;

      bool isEmailOrEvp = keyToSend.contains('@') || keyToSend.length > 20;

      if (!isEmailOrEvp) {
        keyToSend = keyToSend.replaceAll(RegExp(r'[^0-9]'), '');
      }

      final response = await PixReceiveRepository().createCode(
        request: PixCreateQrCodeRequest(
            key: keyToSend,
            amount: cleanAmount,
            title: identifierController.text,
            description: descriptionController.text),
      );

      if (response.success) {
        FocusManager.instance.primaryFocus?.unfocus();
        Get.toNamed(AppRoutes.pixReceiveQrCode, arguments: response);
      }
    });
  }
}
