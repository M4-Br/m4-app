import 'package:app_flutter_miban4/features/completeProfile/controller/complete_profile_document_selfie_controller.dart';
import 'package:get/get.dart';

class CompleteProfileSelfieDocumentBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompleteProfileSelfieDocumentController>(
        () => CompleteProfileSelfieDocumentController());
  }
}
