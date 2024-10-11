import 'package:app_flutter_miban4/data/api/privacyPolicy.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyPolicyController extends GetxController {
  var isLoading = false.obs;

  Future<void> getPrivacy() async {
    isLoading(true);
    try {

      await getPrivacyPolicy();

    } catch (error) {
      isLoading(false);
      Get.snackbar('Erro', 'Falha ao fazer login: $error',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(8));
    }
  }
}
