import 'package:app_flutter_miban4/features/completeProfile/controller/complete_profile_document_photo_controller.dart';
import 'package:get/get.dart';

class CompleteProfileDocumentPhotoBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CompleteProfileDocumentPhotoController());
  }
}
