import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/features/statements/controllers/statement_invoice_controller.dart';
import 'package:get/get.dart';

class StatementInvoiceBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatementInvoiceController>(() => StatementInvoiceController());

    AppLogger.I().debug('Statement Invoice dependencies injected');
  }
}
