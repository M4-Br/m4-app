import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/features/appTerms/controller/privacy_policy_controller.dart';
import 'package:get/get.dart';

class PrivacyPolicyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrivacyPolicyController>(() => PrivacyPolicyController());

    AppLogger.I().info('Privacy Policy dependencies injected');
  }
}
