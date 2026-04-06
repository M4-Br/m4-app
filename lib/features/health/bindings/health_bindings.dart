import 'package:app_flutter_miban4/features/health/controller/health_controller.dart';
import 'package:get/get.dart';

class HealthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HealthHomeController>(() => HealthHomeController());
  }
}
