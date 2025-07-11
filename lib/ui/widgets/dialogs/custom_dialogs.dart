
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
        onCancel: () => Get.back()
    );
  }

  static void showInformationDialog({
    required String content,
    required VoidCallback onCancel
  }) {
    Get.defaultDialog(
      title: 'button_title'.tr.toUpperCase(),
      titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      content: Text(content),
      textConfirm: 'OK',
      onConfirm: onCancel,
    );
  }
}