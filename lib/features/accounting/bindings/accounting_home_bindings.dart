import 'package:app_flutter_miban4/features/accounting/controller/accounting_home_controller.dart';
import 'package:get/get.dart';

class AccountingHomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountingHomeController>(() => AccountingHomeController());
  }
}
