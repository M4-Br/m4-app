import 'package:app_flutter_miban4/features/completeProfile/controller/complete_profile_personal_data_controller.dart';
import 'package:get/get.dart';

class CompleteProfilePersonalDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CompleteProfilePersonalDataController());
  }
}
