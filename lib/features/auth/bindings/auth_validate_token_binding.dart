import 'package:app_flutter_miban4/core/config/auth/controller/user_rx.dart';
import 'package:app_flutter_miban4/features/auth/controller/auth_validate_token_controller.dart';
import 'package:get/get.dart';

class AuthValidateTokenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthValidateTokenController(Get.find<UserRx>()));
  }
}
