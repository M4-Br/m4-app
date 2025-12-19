import 'package:app_flutter_miban4/features/completeProfile/controller/complete_profile_in_review_controller.dart';
import 'package:get/get.dart';

class CompleteProfileReviewBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompleteProfileReviewController>(
        () => CompleteProfileReviewController());
  }
}
