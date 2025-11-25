import 'package:app_flutter_miban4/features/onboarding/controller/onboarding_initial_register_done_controller.dart';
import 'package:get/get.dart';

class OnboardingInitialRegisterDoneBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingInitialRegisterDoneController>(
      () => OnboardingInitialRegisterDoneController(),
    );
  }
}
