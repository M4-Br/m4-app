import 'package:app_flutter_miban4/core/config/auth/controller/user_rx.dart';
import 'package:app_flutter_miban4/features/auth/controller/auth_change_psw_controller.dart';
import 'package:get/get.dart';

class AuthChangePswBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthChangePswController(Get.find<UserRx>()));
  }
}
