
import 'package:app_flutter_miban4/data/api/onboarding/step_six.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_document_choose_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class StepSixController extends GetxController {
  var isLoading = false.obs;

  Future<void> stepSix(String username,
      String motherName,
      String gender,
      String birthDate,
      String maritalStatus,
      String nationality,
      String documentNumber,
      String documentState,
      String issuanceDate,
      bool pep,
      String pepSince) async {
    isLoading(true);

    try {
      final Map<String, dynamic> response = await createStepSix(username, motherName, gender, birthDate, maritalStatus, nationality, documentNumber, documentState, issuanceDate, pep, pepSince);

      if (response['mother_name'].toString().isNotEmpty) {
        Get.off(() => const OnboardingDocumentChoosePage(), transition: Transition.rightToLeft);
      }
    } catch (error) {
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }
}