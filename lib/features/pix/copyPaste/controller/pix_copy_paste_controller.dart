import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/balance/controller/balance_rx.dart';
import 'package:app_flutter_miban4/features/pix/copyPaste/repository/pix_copy_paste_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PixCopyPasteController extends BaseController {
  final BalanceRx balanceRx;
  PixCopyPasteController(this.balanceRx);

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
    isButtonEnabled.value = codeController.text.trim().length >= 10;
  }

  Color get buttonColor => isButtonEnabled.value ? secondaryColor : Colors.grey;

  Future<void> decodeCopyPaste() async {
    if (!isButtonEnabled.value) return;

    FocusManager.instance.primaryFocus?.unfocus();

    await executeSafe(() async {
      final code = codeController.text.trim();

      final result = await PixCopyPasteRepository().decode(code);

      if (result.success == true) {
        Get.toNamed(AppRoutes.pixDecode, arguments: {'qrCode': result});
      }
    });
  }

  void goToCamera() {
    Get.toNamed(AppRoutes.pixQrCodeReader);
  }

  void backToHome() {
    Get.until((route) => route.settings.name == AppRoutes.pixHome);
  }
}
