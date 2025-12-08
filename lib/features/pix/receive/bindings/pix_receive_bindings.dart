import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/features/pix/receive/controller/pix_receive_controller.dart';

class PixReceiveBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PixReceiveController>(
      () => PixReceiveController(),
    );

    AppLogger.I().info('Pix receive dependencies injected');
  }
}
