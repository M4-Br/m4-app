import 'package:app_flutter_miban4/core/config/auth/service/auth_guard.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/digitalAccount/bindings/digital_account_binding.dart';
import 'package:app_flutter_miban4/features/home/bindings/home_binding.dart';
import 'package:app_flutter_miban4/features/digitalAccount/presentation/digital_account_page.dart';
import 'package:app_flutter_miban4/features/home/presentation/home_view_page.dart';
import 'package:app_flutter_miban4/features/marketplace/bindings/partners_binding.dart';
import 'package:app_flutter_miban4/features/marketplace/presentation/marketplace_page.dart';
import 'package:app_flutter_miban4/features/profile/bindings/profile_binding.dart';
import 'package:get/get.dart';

class HomePages {
  static final List<GetPage> page = [
    //Home view
    GetPage(
        name: AppRoutes.homeView,
        page: () => const HomeViewPage(),
        bindings: [
          HomeViewBinding(),
          DigitalAccountBinding(),
          ProfileBinding(),
          MarketplaceBinding(),
        ],
        middlewares: [
          AuthGuard()
        ]),

    //Home Page
    GetPage(
        name: AppRoutes.homePage,
        page: () => const HomeViewPage(),
        middlewares: [AuthGuard()]),

    GetPage(
        name: AppRoutes.digitalAccount,
        page: () => DigitalAccountPage(),
        binding: DigitalAccountBinding(),
        middlewares: [AuthGuard()]),

    GetPage(
        name: AppRoutes.marketplace,
        page: () => MarketplacePage(),
        binding: MarketplaceBinding(),
        middlewares: [AuthGuard()]),

    //Profile Page
    GetPage(
        name: AppRoutes.profile,
        page: () => const HomeViewPage(),
        binding: ProfileBinding(),
        middlewares: [AuthGuard()]),
  ];
}
