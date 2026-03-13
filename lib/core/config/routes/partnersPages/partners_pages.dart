import 'package:app_flutter_miban4/core/config/auth/service/auth_guard.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/partners/binding/partners_binding.dart';
import 'package:app_flutter_miban4/features/partners/presentation/partners_page.dart';
import 'package:get/get.dart';

class PartnersPages {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.partners,
        page: () => PartnersPage(),
        binding: PartnersBinding(),
        middlewares: [AuthGuard()]),
  ];
}
