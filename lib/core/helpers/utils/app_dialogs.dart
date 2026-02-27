import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialogs {
  static void showConfirmationDialog({
    String? title,
    RxBool? loading,
    required String content,
    required VoidCallback onConfirm,
    String? confirmText,
    String? cancelText,
    VoidCallback? onCancel,
  }) {
    Get.defaultDialog(
      title: title?.toUpperCase() ?? 'dialog_error'.tr.toUpperCase(),
      titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          content,
          textAlign: TextAlign.center,
        ),
      ),
      confirm: loading != null
          ? Obx(() => loading.value
              ? const AppLoading()
              : AppButton(
                  onPressed: () async => onConfirm(),
                  labelText: confirmText ?? 'confirm'.tr,
                  color: secondaryColor,
                ))
          : AppButton(
              onPressed: () async => onConfirm(),
              labelText: confirmText ?? 'confirm'.tr,
              color: secondaryColor,
            ),
      cancel: AppButton(
        buttonType: AppButtonType.filled,
        onPressed: () async {
          if (onCancel != null) onCancel();
          Get.back();
        },
        color: Colors.redAccent,
        labelText: cancelText ?? 'cancel'.tr,
      ),
    );
  }

  static void showInformationDialog(
      {String? title,
      required String content,
      required VoidCallback onCancel}) {
    Get.defaultDialog(
      title: title ?? 'dialog_error'.tr.toUpperCase(),
      titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      content: Text(
        content,
        textAlign: TextAlign.center,
      ),
      textConfirm: 'OK',
      onConfirm: onCancel,
      buttonColor: secondaryColor,
      confirmTextColor: Colors.white,
    );
  }

  static void showWidgetDialog({
    required String title,
    required Widget content,
    required VoidCallback onConfirm,
    String? confirmText,
  }) {
    Get.defaultDialog(
      title: title.toUpperCase(),
      titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: content,
      ),
      confirm: AppButton(
        onPressed: () async => onConfirm(),
        labelText: confirmText ?? 'confirm'.tr,
        color: secondaryColor,
      ),
      cancel: AppButton(
        buttonType: AppButtonType.filled,
        onPressed: () async => Get.back(),
        color: Colors.redAccent,
        labelText: 'cancel'.tr,
      ),
    );
  }
}
