import 'package:app_flutter_miban4/features/pix/keyManager/controller/pix_key_manager_controller.dart';
import 'package:get/get.dart';

class PixKeyManagerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PixKeyManagerController>(
      () => PixKeyManagerController(),
    );
  }
}
