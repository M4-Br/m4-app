import 'package:app_flutter_miban4/features/completeProfile/controller/complete_profile_address_controller.dart';
import 'package:get/get.dart';

class CompleteProfileAddressBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompleteProfileAddressController>(
        () => CompleteProfileAddressController());
  }
}
