import 'package:app_flutter_miban4/core/config/auth/service/auth_guard.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/statements/bindings/statement_bindings.dart';
import 'package:app_flutter_miban4/features/statements/bindings/statement_invoice_bindings.dart';
import 'package:app_flutter_miban4/features/statements/presentation/statement_invoice_page.dart';
import 'package:app_flutter_miban4/features/statements/presentation/statement_page.dart';
import 'package:get/get.dart';

class StatementPages {
  static final List<GetPage> pages = [
    //Invoice
    GetPage(
        name: '${AppRoutes.statementInvoice}/:id',
        page: () => const StatementInvoiceScreen(),
        binding: StatementInvoiceBindings(),
        middlewares: [AuthGuard()]),
    GetPage(
        name: AppRoutes.statement,
        page: () => StatementPage(),
        binding: StatementBindings(),
        middlewares: [AuthGuard()]),
  ];
}
