import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowToaster {
  const ShowToaster._();

  static void toasterInfo({required String message, bool isError = false}) {
    FocusManager.instance.primaryFocus?.unfocus();
    Future.delayed(const Duration(milliseconds: 50), () {
      if (Get.context != null) {
        Get.snackbar(
          isError ? 'Erro' : 'Atenção',
          message,
          backgroundColor: isError ? Colors.redAccent : Colors.white,
          colorText: isError ? Colors.white : Colors.black,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.all(16),
          borderRadius: 8,
          duration: const Duration(seconds: 4),
          icon: Icon(
            isError ? Icons.error_outline : Icons.info_outline,
            color: isError ? Colors.white : Colors.blue,
          ),
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
        );
      } else {
        if (kDebugMode) {
          print(
              'ERRO CRÍTICO: Get.context é null. Verifique o GetMaterialApp.');
        }
      }
    });
  }
}
