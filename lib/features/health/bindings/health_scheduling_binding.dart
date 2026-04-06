import 'package:app_flutter_miban4/features/health/controller/health_scheduling_controller.dart';
import 'package:get/get.dart';

class HealthSchedulingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HealthSchedulingController>(() => HealthSchedulingController());
  }
}
