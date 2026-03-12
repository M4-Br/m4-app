import 'package:app_flutter_miban4/core/config/auth/service/auth_guard.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/cashback/bindings/cashback_binding.dart';
import 'package:app_flutter_miban4/features/cashback/presentation/cashback_page.dart';
import 'package:get/get.dart';

class CashbackPages {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.cashback,
        page: () => CashbackPage(),
        binding: CashbackBinding(),
        middlewares: [AuthGuard()]),
  ];
}
