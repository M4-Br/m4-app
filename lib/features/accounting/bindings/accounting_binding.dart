import 'package:app_flutter_miban4/features/accounting/controller/accounting_controller.dart';
import 'package:get/get.dart';

class AccountingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountingController>(() => AccountingController());
  }
}
