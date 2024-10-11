import 'package:app_flutter_miban4/ui/routes/app_routes.dart';
import 'package:app_flutter_miban4/ui/screens/login/login_page.dart';
import 'package:app_flutter_miban4/ui/screens/login/password_page.dart';
import 'package:app_flutter_miban4/ui/screens/login/splash_page.dart';
import 'package:app_flutter_miban4/ui/screens/politics/privacy_policy_page.dart';
import 'package:get/get.dart';

class LoginPages {
  static final List<GetPage> pages = [
    //Splash Screen
    GetPage(name: AppRoutes.splash, page: () => const SplashPage()),

    //Login
    GetPage(name: AppRoutes.login, page: () => const LoginPage()),

    //Password Screen
    GetPage(name: AppRoutes.password, page: () => const PasswordPage()),

    //Privacy Policy Screen
    GetPage(name: AppRoutes.privacy, page: () => const PrivacyPolicyPage()),
  ];
}
