import 'package:app_flutter_miban4/features/barcodeCamera/controller/barcode_camera_controller.dart';
import 'package:get/get.dart';

class BarcodeCameraBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BarcodeCameraController>(() => BarcodeCameraController());
  }
}
