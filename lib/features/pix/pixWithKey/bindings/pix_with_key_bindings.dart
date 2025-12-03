import 'package:app_flutter_miban4/features/pix/pixWithKey/controller/pix_with_key_controller.dart';
import 'package:get/get.dart';

class PixWithKeyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PixWithKeyController>(
      () => PixWithKeyController(),
    );
  }
}
