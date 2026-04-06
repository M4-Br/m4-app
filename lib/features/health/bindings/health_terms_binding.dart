import 'package:app_flutter_miban4/features/health/controller/health_terms_controller.dart';
import 'package:get/get.dart';

class HealthTermsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HealthTermsController>(() => HealthTermsController());
  }
}
