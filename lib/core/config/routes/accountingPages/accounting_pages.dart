import 'package:app_flutter_miban4/core/config/auth/service/auth_guard.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/accounting/bindings/accounting_binding.dart';
import 'package:app_flutter_miban4/features/accounting/presentation/accounting_home_page.dart';
import 'package:get/get.dart';

class AccountingPages {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.accountingHome,
        page: () => AccountingPage(),
        binding: AccountingBinding(),
        middlewares: [AuthGuard()]),
  ];
}
