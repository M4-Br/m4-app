import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/features/profile/controller/change_password_controller.dart';
import 'package:get/get.dart';

class ChangePasswordBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController());

    AppLogger.I().info('Profile change password dependencies injected');
  }
}
