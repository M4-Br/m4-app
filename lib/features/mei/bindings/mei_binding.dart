import 'package:app_flutter_miban4/features/mei/controller/mei_controller.dart';
import 'package:get/get.dart';

class MeiServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MeiServicesController>(() => MeiServicesController());
  }
}
