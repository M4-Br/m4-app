import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/features/pix/receive/controller/pix_receive_qr_code_controller.dart';
import 'package:get/get.dart';

class PixReceiveQrCodeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PixReceiveQrCodeController>(
      () => PixReceiveQrCodeController(),
    );

    AppLogger.I().info('Pix receive qr code dependencies injected');
  }
}
