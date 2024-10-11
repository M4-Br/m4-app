import 'package:app_flutter_miban4/data/api/onboarding/step_four.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_four_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class StepFourController extends GetxController {
  var isLoading = false.obs;

  Future<void> stepFour(
    String postalCode,
    String type,
    String street,
    String number,
    String neighborhood,
    String complement,
    String state,
    String city,
    String country,
  ) async {
    isLoading(true);
    try {
      final Map<String, dynamic> response = await createStepFour(postalCode,
          type, street, number, neighborhood, complement, state, city, country);

      if (response['city'].toString().isNotEmpty) {
        Get.to(() => const OnboardingStepFourPage(), transition: Transition.rightToLeft);
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
