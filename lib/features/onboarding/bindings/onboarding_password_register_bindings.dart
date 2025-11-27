import 'package:app_flutter_miban4/features/onboarding/controller/onboarding_password_register_controller.dart';
import 'package:get/get.dart';

class OnboardingPasswordRegisterBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingPasswordRegisterController>(
        () => OnboardingPasswordRegisterController());
  }
}
