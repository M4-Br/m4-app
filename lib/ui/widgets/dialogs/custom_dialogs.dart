import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialogs {
  static void showConfirmationDialog({
    required String content,
    required VoidCallback onConfirm,
  }) {
    Get.defaultDialog(
        title: 'button_title'.tr.toUpperCase(),
        content: Text(content),
        textConfirm: 'button_confirm'.tr.toUpperCase(),
        textCancel: 'button_cancel'.tr.toUpperCase(),
        onConfirm: onConfirm,
        cancel: AppButton(
          buttonType: AppButtonType.filled,
          onPressed: () async => Get.back(),
          color: Colors.redAccent,
        ),
        buttonColor: secondaryColor,
        confirmTextColor: Colors.white);
  }

  static void showInformationDialog(
      {required String content, required VoidCallback onCancel}) {
    Get.defaultDialog(
      title: 'button_title'.tr.toUpperCase(),
      titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      content: Text(content),
      textConfirm: 'OK',
      onConfirm: onCancel,
      buttonColor: secondaryColor,
      confirmTextColor: Colors.white,
    );
  }
}
