import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/features/onboarding/controller/onboarding_confirm_phone_controller.dart';
import 'package:get/get.dart';

class OnboardingConfirmPhoneBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingConfirmPhoneController>(
        () => OnboardingConfirmPhoneController());

    AppLogger.I().info('Onboarding Phone Confirm dependencies injected');
  }
}
