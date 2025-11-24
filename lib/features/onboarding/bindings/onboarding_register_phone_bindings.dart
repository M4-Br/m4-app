import 'package:app_flutter_miban4/features/onboarding/controller/onboarding_register_phone_controller.dart';
import 'package:get/get.dart';

class OnboardingRegisterPhoneBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingRegisterPhoneController>(
        () => OnboardingRegisterPhoneController());
  }
}
