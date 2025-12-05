import 'package:get/get.dart';
import 'package:app_flutter_miban4/features/services/controller/services_controller.dart';

class ServicesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServicesController>(
      () => ServicesController(),
    );
  }
}
