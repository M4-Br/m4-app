import 'package:app_flutter_miban4/features/profile/controller/customization_controller.dart';
import 'package:get/get.dart';

class CustomizationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomizationController>(() => CustomizationController());
  }
}
