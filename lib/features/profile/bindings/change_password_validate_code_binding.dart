import 'package:app_flutter_miban4/features/profile/controller/change_password_validate_code_controller.dart';
import 'package:get/get.dart';

class ChangePasswordValidateCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordValidateCodeController>(
      () => ChangePasswordValidateCodeController(),
    );
  }
}
