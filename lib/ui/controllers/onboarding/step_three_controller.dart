import 'package:app_flutter_miban4/data/api/onboarding/step_three.dart';
import 'package:app_flutter_miban4/data/model/onboarding/steps.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_phone_confirm_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class StepThreeController extends GetxController {
  var isLoading = false.obs;

  Future<void> stepThree(String id, String prefix, String phone) async {
    isLoading(true);

    try {
      final GetStep response = await createStepThree(id, prefix, phone);

      if (response.phoneNumber!.isNotEmpty) {
        Get.to(
            () => OnboardingPhoneConfirmPage(id: id, phonePrefix: prefix, phoneNumber: phone),
            transition: Transition.rightToLeft);
      } else {
        throw Exception("Falha ao chamar a API: ${response.toString()}");
      }
    } catch (error) {
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }
}
