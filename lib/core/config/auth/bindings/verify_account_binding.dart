import 'package:app_flutter_miban4/core/config/auth/controller/verify_user_controller.dart';
import 'package:app_flutter_miban4/core/config/language/bindings/language_binding.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:get/get.dart';

class VerifyAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyAccountController>(() => VerifyAccountController());

    LanguageBinding().dependencies();

    AppLogger.I().debug('Verify Account Bindings injected');
  }
}
