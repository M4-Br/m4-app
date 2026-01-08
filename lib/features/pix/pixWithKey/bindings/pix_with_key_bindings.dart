import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/features/geral/controller/favorites_controller.dart';
import 'package:app_flutter_miban4/features/pix/pixWithKey/controller/pix_with_key_controller.dart';
import 'package:get/get.dart';

class PixWithKeyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PixWithKeyController>(
      () => PixWithKeyController(Get.find<FavoritesController>()),
    );

    AppLogger.I().info('Pix with key dependencies injected');
  }
}
