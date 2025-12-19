import 'package:app_flutter_miban4/features/completeProfile/controller/complete_profile_selfie_confirm_controller.dart';
import 'package:get/get.dart';

class CompleteProfileConfirmSelfieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompleteProfileConfirmSelfieController>(
        () => CompleteProfileConfirmSelfieController());
  }
}
