import 'package:app_flutter_miban4/features/completeProfile/controller/complete_profile_document_choose.dart';
import 'package:get/get.dart';

class CompleteProfileDocumentChooseBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompleteProfileDocumentChooseController>(
        () => CompleteProfileDocumentChooseController());
  }
}
