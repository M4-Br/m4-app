import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/profile/controller/profile_controller.dart';
import 'package:get/get.dart';

class CompleteProfileDocumentChooseController extends BaseController {
  final RxString selectedDocument = ''.obs;

  void selectDocument(String value) {
    selectedDocument.value = value;
  }

  void nextStep() {
    if (selectedDocument.value.isEmpty) {
      ShowToaster.toasterInfo(
          message: 'Selecione um documento para continuar.');
      return;
    }

    if (Get.isRegistered<ProfileController>()) {
      Get.find<ProfileController>().fetchSteps();
    }

    Get.toNamed(AppRoutes.completeDocumentPhoto,
        arguments: {'docType': selectedDocument.value});
  }
}
