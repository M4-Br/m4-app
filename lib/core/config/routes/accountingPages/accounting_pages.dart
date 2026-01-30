import 'package:app_flutter_miban4/core/config/auth/service/auth_guard.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/accounting/bindings/accounting_home_bindings.dart';
import 'package:app_flutter_miban4/features/accounting/bindings/accounting_payment_bindings.dart';
import 'package:app_flutter_miban4/features/accounting/bindings/accounting_reports_bindings.dart';
import 'package:app_flutter_miban4/features/accounting/presentation/accounting_home_page.dart';
import 'package:app_flutter_miban4/features/accounting/presentation/accounting_payment_page.dart';
import 'package:app_flutter_miban4/features/accounting/presentation/accounting_reposts_page.dart';
import 'package:get/get.dart';

class AccountingPages {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.accountingHome,
        page: () => const AccountingHomePage(),
        binding: AccountingHomeBindings(),
        middlewares: [AuthGuard()]),
    GetPage(
        name: AppRoutes.accountingPayment,
        page: () => const AccountingPaymentPage(),
        binding: AccountingPaymentBindings(),
        middlewares: [AuthGuard()]),
    GetPage(
        name: AppRoutes.accountingReports,
        page: () => const AccountingReportsPage(),
        binding: AccountingReportsBindings(),
        middlewares: [AuthGuard()]),
  ];
}
