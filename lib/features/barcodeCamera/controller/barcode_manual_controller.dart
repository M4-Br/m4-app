import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/barcodeCamera/repository/barcode_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BarcodeManualInputController extends BaseController {
  final codeController = TextEditingController();
  final isButtonEnabled = false.obs;

  @override
  void onInit() {
    super.onInit();
    codeController.addListener(_validateInput);
  }

  @override
  void onClose() {
    codeController.dispose();
    super.onClose();
  }

  void _validateInput() {
    final text = codeController.text.replaceAll(RegExp(r'[^0-9]'), '');
    isButtonEnabled.value = text.length >= 10;
  }

  Color get buttonColor => isButtonEnabled.value ? secondaryColor : Colors.grey;

  Future<void> processBarcode() async {
    if (!isButtonEnabled.value) return;

    FocusManager.instance.primaryFocus?.unfocus();

    await executeSafe(() async {
      final code = codeController.text.replaceAll(RegExp(r'[^0-9]'), '');

      AppLogger.I().info('Processando código manual: $code');

      final result = await BarcodeRepository().decodeBarcode(code);

      if (result.success == true) {
        Get.toNamed(AppRoutes.barcodeConfirmPayment, arguments: result);
      }
    });
  }

  void back() {
    Get.back();
  }
}
