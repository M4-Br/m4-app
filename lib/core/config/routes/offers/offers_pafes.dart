import 'package:app_flutter_miban4/core/config/auth/service/auth_guard.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/offers/binding/offers_bindings.dart';
import 'package:app_flutter_miban4/features/offers/presentation/offers_page.dart';
import 'package:get/get.dart';

class OffersPages {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.offersHome,
        page: () => const OffersPage(),
        binding: OffersBindings(),
        middlewares: [AuthGuard()]),
  ];
}
