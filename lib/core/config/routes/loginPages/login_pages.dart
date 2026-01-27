import 'package:app_flutter_miban4/core/config/auth/bindings/auth_binding.dart';
import 'package:app_flutter_miban4/core/config/auth/bindings/verify_account_binding.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/appTerms/bindings/privacy_policy_bindings.dart';
import 'package:app_flutter_miban4/features/appTerms/presentation/privacy_policy_page.dart';
import 'package:app_flutter_miban4/features/auth/bindings/auth_change_psw_binding.dart';
import 'package:app_flutter_miban4/features/auth/bindings/auth_validate_token_binding.dart';
import 'package:app_flutter_miban4/features/auth/presentation/auth_change_psw_page.dart';
import 'package:app_flutter_miban4/features/auth/presentation/auth_validate_token_page.dart';
import 'package:app_flutter_miban4/features/auth/presentation/login_page.dart';
import 'package:app_flutter_miban4/features/auth/presentation/password_page.dart';
import 'package:app_flutter_miban4/features/splash/bindings/splash_binding.dart';
import 'package:app_flutter_miban4/features/splash/presentation/splash_page.dart';
import 'package:get/get.dart';

class LoginPages {
  static final List<GetPage> pages = [
    //Splash Screen
    GetPage(
        name: AppRoutes.splash,
        page: () => const SplashPage(),
        binding: SplashBinding()),

    //Login Screen
    GetPage(
        name: AppRoutes.login,
        page: () => const LoginPage(),
        binding: VerifyAccountBinding()),

    //Password Screen
    GetPage(
        name: AppRoutes.password,
        page: () => const PasswordPage(),
        binding: AuthBinding()),

    //Validate Token
    GetPage(
        name: AppRoutes.authValidateToken,
        page: () => const AuthValidateTokenPage(),
        binding: AuthValidateTokenBinding()),

    //Change Password
    GetPage(
        name: AppRoutes.authChangePassword,
        page: () => const AuthChangePswPage(),
        binding: AuthChangePswBinding()),

    //Privacy Policy Screen
    GetPage(
        name: AppRoutes.privacyPolicyFromLogin,
        page: () => const PrivacyPolicyPage(),
        binding: PrivacyPolicyBindings()),
  ];
}
