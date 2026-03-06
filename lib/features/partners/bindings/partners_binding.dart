import 'package:app_flutter_miban4/features/partners/controller/partners_controller.dart';
import 'package:get/get.dart';

class PartnersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PartnersController>(() => PartnersController());
  }
}
