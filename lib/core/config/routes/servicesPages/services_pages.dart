import 'package:app_flutter_miban4/core/config/auth/service/auth_guard.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/services/bindings/services_bindings.dart';
import 'package:app_flutter_miban4/features/services/presentation/services_page.dart';
import 'package:get/get.dart';

class ServicesPages {
  static final List<GetPage> pages = [
    //Services
    GetPage(
        name: AppRoutes.services,
        page: () => const ServicesPage(),
        binding: ServicesBindings(),
        middlewares: [AuthGuard()]),
  ];
}
