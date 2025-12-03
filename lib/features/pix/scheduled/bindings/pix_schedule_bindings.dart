import 'package:app_flutter_miban4/features/pix/scheduled/controller/pix_schedule_controller.dart';
import 'package:get/get.dart';

class PixScheduleBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PixScheduleController>(
      () => PixScheduleController(),
    );
  }
}
