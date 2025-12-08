import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/features/pix/limits/controller/pix_limits_controller.dart';
import 'package:get/get.dart';

class PixMyLimitsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PixLimitsController>(
      () => PixLimitsController(),
    );

    AppLogger.I().info('Pix Limits dependencies injected');
  }
}
