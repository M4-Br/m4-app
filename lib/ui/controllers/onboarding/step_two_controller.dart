import 'package:app_flutter_miban4/data/api/onboarding/step_two.dart';
import 'package:app_flutter_miban4/data/model/onboarding/steps.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_email_confirm_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class StepTwoController extends GetxController {
  var isLoading = false.obs;

  Future<void> stepTwo(String id, String name, String username, String email,
      String? promoCode) async {
    try {
      isLoading(true);

      final GetStep response =
          await createStepTwo(id, name, username, email, promoCode);

      if (response.name!.isNotEmpty) {
        Get.to(
            () => OnboardingEmailConfirmPage(
                  id: id,
                  name: name,
                  username: username,
                  email: email,
                ),
            transition: Transition.rightToLeft);
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
