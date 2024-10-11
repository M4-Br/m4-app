import 'package:app_flutter_miban4/data/api/onboarding/confirm_email.dart';
import 'package:app_flutter_miban4/data/model/onboarding/steps.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_two_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ValidateEmailController extends GetxController {
  var isLoading = false.obs;

  Future<void> emailValidate(String id, String name, String username,
      String email, String? promoCode, String code) async {
    isLoading(true);
    try {
      final GetStep response =
          await validateEmail(id, name, username, email, promoCode, code);

      if (response.email!.isNotEmpty) {
        Get.to(() => const OnboardingStepTwoPage(), transition: Transition.rightToLeft);
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
