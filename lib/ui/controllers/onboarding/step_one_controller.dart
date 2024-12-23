import 'package:app_flutter_miban4/data/api/login/documentVerify.dart';
import 'package:app_flutter_miban4/data/api/onboarding/step_one.dart';
import 'package:app_flutter_miban4/data/model/onboarding/steps.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:app_flutter_miban4/ui/controllers/login/verify_document_controller.dart';
import 'package:app_flutter_miban4/ui/screens/login/password_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_document_choose_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_approved_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_in_review_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_seven_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_four_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_three_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_eight_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_five_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_two_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_one_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StepOneController extends GetxController {
  var isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final TextEditingController cpfController = TextEditingController();
  var check = false.obs;

  Future<void> stepOne(String document) async {
    isLoading(true);

    try {
      final GetStep response = await createStepOne(document);

      if (response.id.toString().isNotEmpty) {
        Get.to(() => OnboardingStepOnePage(
              id: response.id.toString(),
            ));
      } else {
        throw Exception('Erro ao chamar a API: ${response.toString()}');
      }
    } catch (error) {
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }

  Future<void> verifyDocument(String document, int page) async {
    isLoading(true);

    try {
      final Map<String, dynamic> response =
          await getDocumentVerify(document, page);

      if (response.containsKey('id')) {
        await SharedPreferencesFunctions.saveString(
            key: 'id', value: response['id'].toString());
        await SharedPreferencesFunctions.saveString(
            key: 'document', value: document);

        if (response['status'] == 'approved' &&
            response['steps']![8]['done'] == true) {
          isLoading(false);
          Get.to(
              () => PasswordPage(
                    document: response['document'],
                  ),
              transition: Transition.rightToLeft);
        } else if (response['document'].toString().isNotEmpty &&
            response['steps']![0]['done'] == false) {
          isLoading(false);
          Get.to(() => OnboardingStepOnePage(
                id: response['id'].toString(),
              ));
        } else if (response['steps']![0]['done'] == false) {
          isLoading(false);
          stepOne(document);
        } else if (response['steps']![1]['done'] == false) {
          isLoading(false);
          Get.to(() => const OnboardingStepTwoPage(),
              transition: Transition.rightToLeft);
        } else if (response['steps']![2]['done'] == false) {
          isLoading(false);
          Get.to(() => const OnboardingStepThreePage(),
              transition: Transition.rightToLeft);
        } else if (response['steps']![3]['done'] == false) {
          isLoading(false);
          Get.to(() => const OnboardingStepFourPage(),
              transition: Transition.rightToLeft);
        } else if (response['steps']![4]['done'] == false) {
          isLoading(false);
          Get.to(() => const OnboardingStepFivePage(),
              transition: Transition.rightToLeft);
        } else if (response['steps']![5]['done'] == false) {
          isLoading(false);
          Get.to(() => const OnboardingDocumentChoosePage(),
              transition: Transition.rightToLeft);
        } else if (response['steps']![6]['done'] == false) {
          isLoading(false);
          Get.to(() => const OnboardingStepSevenPage(),
              transition: Transition.rightToLeft);
        } else if (response['steps']![7]['done'] == false) {
          isLoading(false);
          Get.to(() => const OnboardingStepEightPage(),
              transition: Transition.rightToLeft);
        } else if (response['status'] == 'pending' &&
            response['steps']![8]['done'] == false) {
          isLoading(false);
          Get.to(() => const OnboardingInReviewPage(),
              transition: Transition.rightToLeft);
        } else if (response['status'] == 'approved' &&
            response['steps']![8]['done'] == false) {
          isLoading(false);
          Get.to(() => const OnboardingApprovedPage(),
              transition: Transition.rightToLeft);
        }
      } else {
        stepOne(document);
      }
    } catch (error) {
      stepOne(document);
      isLoading(false);
    }
  }

  Future<void> _stepOne() async {
    if (formKey.currentState!.validate()) {
      if (check.value) {
        String document =
            cpfController.text.replaceAll(".", "").replaceAll("-", "");
        try {
          await verifyDocument(document, 1);
        } catch (error) {
          throw Exception(error);
        }
      }
    }
  }
}
