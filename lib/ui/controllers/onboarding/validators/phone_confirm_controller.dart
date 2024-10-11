import 'package:app_flutter_miban4/data/api/onboarding/confirm_phone.dart';
import 'package:app_flutter_miban4/data/model/onboarding/steps.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_three_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PhoneConfirmController extends GetxController {
  var isLoading = false.obs;

  Future<void> confirmPhone(
      String id, String prefix, String phone, String code) async {
    isLoading(true);

    try {
      final Map<String, dynamic> response = await phoneConfirm(id, prefix, phone, code);

      if (response['phone'].isNotEmpty) {
        Get.to(() => const OnboardingStepThreePage(), transition: Transition.rightToLeft);
      } else {
        throw Exception('Erro ao chamar a API: ${response.toString()}');
      }
    } catch (error) {
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }
}
