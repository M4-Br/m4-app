import 'package:app_flutter_miban4/core/config/auth/service/auth_guard.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/mei/bindings/das_binding.dart';
import 'package:app_flutter_miban4/features/mei/bindings/mei_binding.dart';
import 'package:app_flutter_miban4/features/mei/presentation/das_page.dart';
import 'package:app_flutter_miban4/features/mei/presentation/mei_page.dart';
import 'package:get/get.dart';

class MeiPages {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.mei,
        page: () => MeiServicesPage(),
        binding: MeiServicesBinding(),
        middlewares: [AuthGuard()]),
    GetPage(
        name: AppRoutes.dasMei,
        page: () => DasPage(),
        binding: DasBinding(),
        middlewares: [AuthGuard()]),
  ];
}
