import 'package:app_flutter_miban4/features/accounting/controller/accounting_payment_controller.dart';
import 'package:get/get.dart';

class AccountingPaymentBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountingPaymentController>(
        () => AccountingPaymentController());
  }
}
