import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/features/pix/keyManager/controller/pix_add_new_key_controller.dart';
import 'package:get/get.dart';

class PixAddNewKeyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PixAddNewKeyController>(
      () => PixAddNewKeyController(),
    );

    AppLogger.I().info('Pix add new key dependencies injected');
  }
}
