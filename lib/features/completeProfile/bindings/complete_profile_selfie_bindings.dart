import 'package:app_flutter_miban4/features/completeProfile/controller/complete_profile_selfie_controller.dart';
import 'package:get/get.dart';

class CompleteProfileSelfieBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompleteProfileSelfieController>(
        () => CompleteProfileSelfieController());
  }
}
