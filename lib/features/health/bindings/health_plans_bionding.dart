import 'package:app_flutter_miban4/features/health/controller/health_plans_controller.dart';
import 'package:get/get.dart';

class HealthPlansBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HealthPlansController>(() => HealthPlansController());
  }
}
