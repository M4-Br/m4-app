import 'package:app_flutter_miban4/features/mei/controller/das_controller.dart';
import 'package:get/get.dart';

class DasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DasController>(() => DasController());
  }
}
