import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/features/qrCodeCamera/controller/qrcode_camera_controller.dart';
import 'package:get/get.dart';

class QrCodeCameraBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QrCodeCameraController>(
      () => QrCodeCameraController(),
    );

    AppLogger.I().debug('QR Camera dependencies injected');
  }
}
