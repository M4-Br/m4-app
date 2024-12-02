import 'package:app_flutter_miban4/data/api/login/documentVerify.dart';
import 'package:app_flutter_miban4/data/util/helpers/mask.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:app_flutter_miban4/ui/screens/login/code_validate/code_validate_page.dart';
import 'package:app_flutter_miban4/ui/screens/login/password_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_approved_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_document_choose_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_in_review_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_eight_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_five_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_four_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_one_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_seven_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_three_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_two_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class VerifyController extends GetxController {
  var isLoading = false.obs;
  final documentController = TextEditingController();
  String document = '';
  final formKey = GlobalKey<FormState>();
  final box = GetStorage();

  Future<void> verifyDocument(String document, int page) async {
    isLoading(true);

    try {
      final Map<String, dynamic> response =
          await getDocumentVerify(document, page);

      box.write('defaulter', response['defaulter_user'].toString());

      if (document.length > 11 &&
          response['type'] == 'PJ' &&
          response['first_access'] == true) {
        Get.to(() => const CodeValidatePage(page: 1),
            transition: Transition.rightToLeft);
        isLoading(false);
      } else if (response['first_access'] == false) {
        isLoading(false);
        Get.to(
            () => PasswordPage(
                  document: response['document'],
                ),
            transition: Transition.rightToLeft);
      } else if (response['status'] == 'approved' &&
          response['steps']![8]['done'] == true) {
        isLoading(false);
        Get.to(
            () => PasswordPage(
                  document: response['document'],
                ),
            transition: Transition.rightToLeft);
      } else if (response['steps']![0]['done'] == false) {
        isLoading(false);
        Get.to(() => const OnboardingStepOnePage(), transition: Transition.rightToLeft);
      } else if (response['steps']![1]['done'] == false) {
        isLoading(false);
        Get.to(() => const OnboardingStepTwoPage(), transition: Transition.rightToLeft);
      } else if (response['steps']![2]['done'] == false) {
        isLoading(false);
        Get.to(() => const OnboardingStepThreePage(), transition: Transition.rightToLeft);
      } else if (response['steps']![3]['done'] == false) {
        isLoading(false);
        Get.to(() => const OnboardingStepFourPage(), transition: Transition.rightToLeft);
      } else if (response['steps']![4]['done'] == false) {
        isLoading(false);
        Get.to(() => const OnboardingStepFivePage(), transition: Transition.rightToLeft);
      } else if (response['steps']![5]['done'] == false) {
        isLoading(false);
        Get.to(() => const OnboardingDocumentChoosePage(),
            transition: Transition.rightToLeft);
      } else if (response['steps']![6]['done'] == false) {
        isLoading(false);
        Get.to(() => const OnboardingStepSevenPage(), transition: Transition.rightToLeft);
      } else if (response['steps']![7]['done'] == false) {
        isLoading(false);
        Get.to(() => const OnboardingStepEightPage(), transition: Transition.rightToLeft);
      } else if (response['status'] == 'pending' &&
          response['steps']![8]['done'] == false) {
        isLoading(false);
        Get.to(() => const OnboardingInReviewPage(), transition: Transition.rightToLeft);
      } else if (response['status'] == 'approved' &&
          response['steps']![8]['done'] == false) {
        isLoading(false);
        Get.to(() => const OnboardingApprovedPage(), transition: Transition.rightToLeft);
      } else {
        throw Exception("Resposta inválida da API");
      }
    } catch (error) {
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }

  documentInitialVerify() async {
    if (formKey.currentState!.validate()) {
      String cpf = documentController.text
          .replaceAll(".", "")
          .replaceAll("-", "")
          .replaceAll("/", "")
          .toString();

      await SharedPreferencesFunctions.saveString(
          key: 'codeLang', value: 'codeLang'.tr);

      try {
        await verifyDocument(cpf, 0);
      } catch (error) {
        throw Exception(error);
      }
    }
  }

  lastLogin() async {
    document = await SharedPreferencesFunctions.getString(key: 'document');

    if (document.length == 11) {
      documentController.text = cpfMaskFormatter.maskText(document) ?? '';
    } else if (document.length > 11) {
      documentController.text = cnpjMaskFormatter.maskText(document) ?? '';
    }
  }
}
