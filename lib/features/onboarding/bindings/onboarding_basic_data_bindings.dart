import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/features/onboarding/controller/onboarding_basic_data_controller.dart';
import 'package:get/get.dart';

class OnboardingBasicDataBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingBasicDataController>(
        () => OnboardingBasicDataController());

    AppLogger.I().info('Onboarding Basic dependencies injected');
  }
}
