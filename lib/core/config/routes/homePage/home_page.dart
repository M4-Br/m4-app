import 'package:app_flutter_miban4/core/config/auth/service/auth_guard.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/home/bindings/home_binding.dart';
import 'package:app_flutter_miban4/features/home/presentation/home_page.dart';
import 'package:app_flutter_miban4/features/home/presentation/home_view_page.dart';
import 'package:app_flutter_miban4/features/profile/bindings/profile_binding.dart';
import 'package:app_flutter_miban4/features/profile/presentation/profile_page.dart';
import 'package:app_flutter_miban4/features/statements/bindings/statement_bindings.dart';
import 'package:app_flutter_miban4/features/statements/presentation/statement_page.dart';
import 'package:get/get.dart';

class HomePages {
  static final List<GetPage> page = [
    //Home view
    GetPage(
        name: AppRoutes.homeView,
        page: () => const HomeViewPage(),
        binding: HomeViewBinding(),
        middlewares: [AuthGuard()]),

    //Home Page
    GetPage(
        name: AppRoutes.homePage,
        page: () => HomePage(),
        middlewares: [AuthGuard()]),

    //Statement Page
    GetPage(
        name: AppRoutes.statement,
        page: () => const StatementPage(),
        binding: StatementBindings(),
        middlewares: [AuthGuard()]),

    //Profile Page
    GetPage(
        name: AppRoutes.profile,
        page: () => const ProfilePage(),
        binding: ProfileBinding(),
        middlewares: [AuthGuard()]),
  ];
}
