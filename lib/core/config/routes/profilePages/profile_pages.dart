import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/profile/bindings/plans_binding.dart';
import 'package:app_flutter_miban4/features/profile/presentation/change_password_page.dart';
import 'package:app_flutter_miban4/features/profile/presentation/financial_data_page.dart';
import 'package:app_flutter_miban4/features/profile/presentation/plans_page.dart';
import 'package:app_flutter_miban4/ui/screens/politics/privacy_policy_page.dart';
import 'package:app_flutter_miban4/ui/screens/politics/terms_page.dart';
import 'package:get/get.dart';

class ProfilePages {
  static final List<GetPage> pages = [
    //Change Password
    GetPage(
        name: AppRoutes.changePassword, page: () => const ChangePasswordPage()),

    //Financial Data
    GetPage(
        name: AppRoutes.financialData, page: () => const FinancialDataPage()),

    //Plans
    GetPage(
        name: AppRoutes.plans,
        page: () => const PlansPage(),
        binding: PlansBindings()),

    //Terms
    GetPage(name: AppRoutes.terms, page: () => const TermsPage()),

    //Prvacy
    GetPage(
        name: AppRoutes.privacyProfile, page: () => const PrivacyPolicyPage()),
  ];
}
