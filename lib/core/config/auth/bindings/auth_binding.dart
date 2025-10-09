import 'package:app_flutter_miban4/core/config/auth/controller/auth_controller.dart';
import 'package:app_flutter_miban4/core/config/auth/controller/user_rx.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController(user: Get.find<UserRx>()));

    AppLogger.I().debug('Auth Binding injected');
  }
}
