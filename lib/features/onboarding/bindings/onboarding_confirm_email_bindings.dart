import 'package:app_flutter_miban4/features/onboarding/controller/onboarding_confirm_email_controller.dart';
import 'package:get/get.dart';

class OnboardingConfirmEmailBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingConfirmEmailController>(
        () => OnboardingConfirmEmailController());
  }
}
