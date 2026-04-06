import 'package:app_flutter_miban4/features/accounting/controller/accounting_reports_controller.dart';
import 'package:get/get.dart';

class AccountingReportsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountingReportsController>(
        () => AccountingReportsController());
  }
}
