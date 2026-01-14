import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/completeProfile/repository/complete_profile_document_photo_repository.dart';
import 'package:app_flutter_miban4/features/profile/controller/profile_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CompleteProfileDocumentPhotoController extends BaseController {
  final isFrontSent = false.obs;
  final isBackSent = false.obs;

  late String documentType;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null && args['docType'] != null) {
      documentType = args['docType'];
    } else {
      documentType = 'rg';
    }
  }

  Future<void> takePhoto(String side) async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (photo != null) {
        await _uploadPhoto(side, photo);
      }
    } catch (e) {
      ShowToaster.toasterInfo(message: 'Erro ao abrir câmera: $e');
    }
  }

  Future<void> _uploadPhoto(String side, XFile photo) async {
    await executeSafe(() async {
      final result = await CompleteProfileDocumentPhotoRepository()
          .uploadDocument(
              id: userRx.user.value!.payload.id.toString(),
              imageType: side,
              documentType: documentType,
              photo: photo);

      if (side == 'front') {
        isFrontSent.value = true;
      } else {
        isBackSent.value = true;
      }

      final documentPhotoStep =
          result.steps.firstWhereOrNull((step) => step.stepId == 6);

      if (documentPhotoStep!.done == true) {
        ShowToaster.toasterInfo(message: 'Fotos enviadas com sucesso');
      }
    });
  }

  void nextStep() {
    if (isFrontSent.value && isBackSent.value) {
      if (Get.isRegistered<ProfileController>()) {
        Get.find<ProfileController>().fetchSteps();
      }

      Get.toNamed(AppRoutes.completeDocumentPhotoSelfie);
    } else {
      ShowToaster.toasterInfo(message: 'Envie as duas fotos para continuar.');
    }
  }
}
