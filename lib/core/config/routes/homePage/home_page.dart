import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/ui/screens/home/home/home_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/home_view_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/perfil/profile_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/statement/statement_page.dart';
import 'package:get/get.dart';

class HomePages {
  static final List<GetPage> page = [
    //Home view
    GetPage(name: AppRoutes.homeView, page: () => const HomeViewPage()),

    //Home Page
    GetPage(name: AppRoutes.homePage, page: () => const HomePage()),

    //Statement Page
    GetPage(name: AppRoutes.statement, page: () => const StatementPage()),

    //Profile Page
    GetPage(name: AppRoutes.profile, page: () => const ProfilePage())
  ];
}
