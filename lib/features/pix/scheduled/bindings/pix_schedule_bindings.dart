import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/features/pix/scheduled/controller/pix_schedule_controller.dart';
import 'package:get/get.dart';

class PixScheduleBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PixScheduleController>(
      () => PixScheduleController(),
    );

    AppLogger.I().info('Pix schedule dependencies injected');
  }
}
