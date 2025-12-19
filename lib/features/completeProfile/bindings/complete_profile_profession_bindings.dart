import 'package:app_flutter_miban4/features/completeProfile/controller/complete_profile_profession_controller.dart';
import 'package:get/get.dart';

class CompleteProfileProfessionBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompleteProfileProfessionController>(
        () => CompleteProfileProfessionController());
  }
}
