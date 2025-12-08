import 'package:app_flutter_miban4/features/balance/controller/balance_rx.dart';
import 'package:app_flutter_miban4/features/barcodeCamera/controller/barcode_confirm_payment_controller.dart';
import 'package:get/get.dart';

class BarcodeConfirmPaymentBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BarcodeConfirmPaymentController>(
        () => BarcodeConfirmPaymentController(Get.find<BalanceRx>()));
  }
}
