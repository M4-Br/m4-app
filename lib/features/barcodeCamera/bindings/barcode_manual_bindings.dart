import 'package:app_flutter_miban4/features/barcodeCamera/controller/barcode_manual_controller.dart';
import 'package:get/get.dart';

class BarcodeManualBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BarcodeManualInputController>(
        () => BarcodeManualInputController());
  }
}
