import 'package:app_flutter_miban4/core/config/auth/service/auth_guard.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/appTerms/bindings/privacy_policy_bindings.dart';
import 'package:app_flutter_miban4/features/appTerms/bindings/terms_bindings.dart';
import 'package:app_flutter_miban4/features/appTerms/presentation/privacy_policy_page.dart';
import 'package:app_flutter_miban4/features/appTerms/presentation/terms_page.dart';
import 'package:app_flutter_miban4/features/profile/bindings/change_password_binding.dart';
import 'package:app_flutter_miban4/features/profile/bindings/change_password_validate_code_binding.dart';
import 'package:app_flutter_miban4/features/profile/bindings/company_manager_binding.dart';
import 'package:app_flutter_miban4/features/profile/bindings/financial_binding.dart';
import 'package:app_flutter_miban4/features/profile/bindings/plans_binding.dart';
import 'package:app_flutter_miban4/features/profile/presentation/change_password_page.dart';
import 'package:app_flutter_miban4/features/profile/presentation/change_password_validate_code_page.dart';
import 'package:app_flutter_miban4/features/profile/presentation/company_manager_page.dart';
import 'package:app_flutter_miban4/features/profile/presentation/financial_data_page.dart';
import 'package:app_flutter_miban4/features/profile/presentation/plans_page.dart';
import 'package:app_flutter_miban4/features/profile/bindings/customization_binding.dart';
import 'package:app_flutter_miban4/features/profile/presentation/customization_page.dart';
import 'package:get/get.dart';

class ProfilePages {
  static final List<GetPage> pages = [
    //Change Password
    GetPage(
        name: AppRoutes.changePasswordEmailConfirm,
        page: () => const ChangePasswordValidateCodePage(),
        binding: ChangePasswordValidateCodeBinding(),
        middlewares: [AuthGuard()]),

    GetPage(
        name: AppRoutes.changePasswordFromProfile,
        page: () => const ChangePasswordPage(),
        binding: ChangePasswordBinding(),
        middlewares: [AuthGuard()]),

    //Financial Data
    GetPage(
        name: AppRoutes.financialData,
        page: () => const FinancialDataPage(),
        binding: FinancialParamsBinding(),
        middlewares: [AuthGuard()]),

    //Plans
    GetPage(
        name: AppRoutes.plans,
        page: () => const PlansPage(),
        binding: PlansBindings(),
        middlewares: [AuthGuard()]),

    //Terms
    GetPage(
        name: AppRoutes.termsFromProfile,
        page: () => const TermsPage(),
        binding: TermsBindings(),
        middlewares: [AuthGuard()]),

    //Prvacy
    GetPage(
        name: AppRoutes.privacyPolicyFromLogin,
        page: () => const PrivacyPolicyPage(),
        binding: PrivacyPolicyBindings()),

    //Company
    GetPage(
        name: AppRoutes.companyManager,
        page: () => CompanyManagerPage(),
        binding: CompanyManagerBinding(),
        middlewares: [AuthGuard()]),
    //Customization
    GetPage(
        name: AppRoutes.customization,
        page: () => const CustomizationPage(),
        binding: CustomizationBinding(),
        middlewares: [AuthGuard()]),
  ];
}
