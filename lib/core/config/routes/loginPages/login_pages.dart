import 'package:app_flutter_miban4/core/config/auth/bindings/auth_binding.dart';
import 'package:app_flutter_miban4/core/config/auth/bindings/verify_account_binding.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/auth/presentation/login_page.dart';
import 'package:app_flutter_miban4/features/auth/presentation/password_page.dart';
import 'package:app_flutter_miban4/features/splash/bindings/splash_binding.dart';
import 'package:app_flutter_miban4/features/splash/presentation/splash_page.dart';
import 'package:app_flutter_miban4/ui/screens/politics/privacy_policy_page.dart';
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

    //Privacy Policy Screen
    GetPage(name: AppRoutes.privacy, page: () => const PrivacyPolicyPage()),
  ];
}
