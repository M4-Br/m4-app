import 'package:get/get.dart';
import 'package:app_flutter_miban4/features/store/controller/store_controller.dart';

class StoreBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StoreController>(
      () => StoreController(),
    );
  }
}
