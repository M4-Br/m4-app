import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/onboarding/bindings/onboarding_basic_data_bindings.dart';
import 'package:app_flutter_miban4/features/onboarding/bindings/onboarding_confirm_email_bindings.dart';
import 'package:app_flutter_miban4/features/onboarding/bindings/onboarding_document_bindings.dart';
import 'package:app_flutter_miban4/features/onboarding/bindings/onboarding_password_register_bindings.dart';
import 'package:app_flutter_miban4/features/onboarding/bindings/onboarding_phone_confirm_bindings.dart';
import 'package:app_flutter_miban4/features/onboarding/bindings/onboarding_register_phone_bindings.dart';
import 'package:app_flutter_miban4/features/onboarding/presentation/onboarding_basic_data_page.dart';
import 'package:app_flutter_miban4/features/onboarding/presentation/onboarding_confirm_email_page.dart';
import 'package:app_flutter_miban4/features/onboarding/presentation/onboarding_confirm_phone_page.dart';
import 'package:app_flutter_miban4/features/onboarding/presentation/onboarding_document_page.dart';
import 'package:app_flutter_miban4/features/onboarding/presentation/onboarding_register_phone_page.dart';
import 'package:app_flutter_miban4/features/onboarding/presentation/onboarding_register_password_page.dart';
import 'package:get/get.dart';

class OnboardingPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.onboardingDocument,
      page: () => const OnboardingDocumentPage(),
      binding: OnboardingDocumentBindings(),
    ),
    GetPage(
        name: AppRoutes.onboardingBasicData,
        page: () => const OnboardingBasicDataPage(),
        binding: OnboardingBasicDataBindings()),
    GetPage(
      name: AppRoutes.onboardingConfirmEmail,
      page: () => const OnboardingConfirmEmailPage(),
      binding: OnboardingConfirmEmailBindings(),
    ),
    GetPage(
      name: AppRoutes.onboardingPhone,
      page: () => const OnboardingRegisterPhonePage(),
      binding: OnboardingRegisterPhoneBindings(),
    ),
    GetPage(
      name: AppRoutes.onboardingPhoneConfirm,
      page: () => const OnboardingConfirmPhonePage(),
      binding: OnboardingConfirmPhoneBindings(),
    ),
    GetPage(
      name: AppRoutes.onboardingRegisterPassword,
      page: () => const OnboardingRegisterPasswordPage(),
      binding: OnboardingPasswordRegisterBindings(),
    ),
  ];
}
