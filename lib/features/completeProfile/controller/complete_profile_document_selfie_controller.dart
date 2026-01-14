import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/completeProfile/repository/complete_profile_document_selfie_repository.dart';
import 'package:app_flutter_miban4/features/profile/controller/profile_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CompleteProfileSelfieDocumentController extends BaseController {
  final ImagePicker _picker = ImagePicker();

  Future<void> takeSelfie() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 80,
      );

      if (photo != null) {
        await _uploadPhoto(photo);
      }
    } catch (e, s) {
      AppLogger.I().error('Open camera', e, s);
      ShowToaster.toasterInfo(message: 'Erro ao abrir câmera: $e');
    }
  }

  Future<void> _uploadPhoto(XFile photo) async {
    await executeSafe(() async {
      if (kDebugMode) {
        print('Enviando Selfie com Documento: ${photo.path}');
      }

      final id = userRx.user.value!.payload.id.toString();

      final result = await CompleteProfileDocumentSelfieRepository()
          .sendDocumentSelfie(id, photo);

      final documentSelfieStep =
          result.steps.firstWhereOrNull((step) => step.stepId == 7);

      if (Get.isRegistered<ProfileController>()) {
        Get.find<ProfileController>().fetchSteps();
      }

      if (documentSelfieStep!.done == true) {
        Get.toNamed(AppRoutes.completeSelfie);
      }
    });
  }
}
