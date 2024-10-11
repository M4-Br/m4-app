import 'package:app_flutter_miban4/ui/routes/app_routes.dart';
import 'package:app_flutter_miban4/ui/screens/home/statement/statement_voucher_page.dart';
import 'package:get/get.dart';

class StatementPages {
  static final List<GetPage> pages = [
    //Invoice
    GetPage(name: AppRoutes.statementInvoice, page: () => const StatementVoucherScreen())
  ];
}