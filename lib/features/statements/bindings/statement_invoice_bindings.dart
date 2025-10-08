import 'package:app_flutter_miban4/features/statements/controllers/statement_invoice_controller.dart';
import 'package:get/get.dart';

class StatementInvoiceBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatementInvoiceController>(() => StatementInvoiceController());
  }
}
