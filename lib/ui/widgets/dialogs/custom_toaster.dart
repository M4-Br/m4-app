import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowToaster {
  const ShowToaster._();

  static void toasterInfo({required String message}) {
    Get.snackbar(
      'Info',
      message,
      backgroundColor: Colors.white,
      colorText: Colors.black,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }
}
