import 'package:app_flutter_miban4/features/barcodeCamera/controller/barcode_voucher_controller.dart';
import 'package:get/get.dart';

class BarcodeVoucherBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BarcodeVoucherController>(() => BarcodeVoucherController());
  }
}
