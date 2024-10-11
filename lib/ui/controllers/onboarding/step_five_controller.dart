import 'package:app_flutter_miban4/data/api/onboarding/step_five.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_five_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class StepFiveController extends GetxController {
  var isLoading = false.obs;

  Future<void> stepFive(String professionId, int income) async {
    isLoading(true);

    try {
      final Map<String, dynamic> response =
          await createStepFive(professionId, income);

      if (response['professionIncome'].toString().isNotEmpty) {
        Get.to(() => const OnboardingStepFivePage(), transition: Transition.rightToLeft);
      }
    } catch (error) {
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }
}
