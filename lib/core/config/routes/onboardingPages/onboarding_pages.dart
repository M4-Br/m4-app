import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/ui/screens/login/code_validate/code_validate_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_approved_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_document_choose_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_email_confirm_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_in_review_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_password_register_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_phone_confirm_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_privacy_policy_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_screen.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_selfie_confirm_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_eight_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_five_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_four_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_one_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_seven_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_six_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_three_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_two_page.dart';
import 'package:get/get.dart';

class OnboardingPages {
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.onboarding, page: () => const OnboardingPage()),
    GetPage(
        name: AppRoutes.onboardingStepOne,
        page: () => const OnboardingStepOnePage()),
    GetPage(
        name: AppRoutes.onboardingStepTwo,
        page: () => const OnboardingStepTwoPage()),
    GetPage(
        name: AppRoutes.onboardingStepThree,
        page: () => const OnboardingStepThreePage()),
    GetPage(
        name: AppRoutes.onboardingStepFour,
        page: () => const OnboardingStepFourPage()),
    GetPage(
        name: AppRoutes.onboardingStepFive,
        page: () => const OnboardingStepFivePage()),
    GetPage(
        name: AppRoutes.onboardingStepSix,
        page: () => const OnboardingStepSixPage()),
    GetPage(
        name: AppRoutes.onboardingStepSeven,
        page: () => const OnboardingStepSevenPage()),
    GetPage(
        name: AppRoutes.onboardingStepEight,
        page: () => const OnboardingStepEightPage()),
    GetPage(
        name: AppRoutes.onboardingPhoneConfirm,
        page: () => const OnboardingPhoneConfirmPage()),
    GetPage(
        name: AppRoutes.onboardingEmailConfirm,
        page: () => const OnboardingEmailConfirmPage()),
    GetPage(
        name: AppRoutes.onboardingDocumentChoose,
        page: () => const OnboardingDocumentChoosePage()),
    GetPage(
        name: AppRoutes.onboardingSelfieConfirm,
        page: () => const OnboardingSelfieConfirmPage(
              result: {},
            )),
    GetPage(
        name: AppRoutes.onboardingPasswordRegister,
        page: () => const OnboardingPasswordRegisterPage()),
    GetPage(
        name: AppRoutes.onboardingPrivacyPolicy,
        page: () => const OnboardingPrivacyPolicyPage()),
    GetPage(
        name: AppRoutes.onboardingReview,
        page: () => const OnboardingInReviewPage()),
    GetPage(
        name: AppRoutes.onboardingApproved,
        page: () => const OnboardingApprovedPage()),

    //Code Validator
    GetPage(name: AppRoutes.codeValidate, page: () => const CodeValidatePage())
  ];
}
