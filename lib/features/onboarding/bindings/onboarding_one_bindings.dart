import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/features/onboarding/controller/onboarding_one_controller.dart';
import 'package:get/get.dart';

class OnboardingOneBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingOneController>(() => OnboardingOneController());

    AppLogger.I().info('Onboarding Step one bindings injected');
  }
}
