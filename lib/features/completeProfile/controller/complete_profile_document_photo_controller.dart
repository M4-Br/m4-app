import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/completeProfile/repository/complete_profile_document_photo_repository.dart';
import 'package:app_flutter_miban4/features/profile/controller/profile_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class CompleteProfileDocumentPhotoController extends BaseController {
  final isFrontSent = false.obs;
  final isBackSent = false.obs;

  final box = GetStorage();

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
    _checkLostData();
  }

  Future<void> _checkLostData() async {
    try {
      final LostDataResponse response = await _picker.retrieveLostData();

      if (response.isEmpty) {
        return;
      }

      if (response.file != null) {
        final String? pendingSide = box.read('pending_photo_side');

        if (pendingSide != null) {
          await _uploadPhoto(pendingSide, response.file!);
          box.remove('pending_photo_side');
        }
      } else {
        if (response.exception != null) {
          ShowToaster.toasterInfo(
              message: 'Erro ao recuperar foto: ${response.exception!.code}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao checar lost data: $e');
      }
    }
  }

  Future<void> takePhoto(String side) async {
    try {
      box.write('pending_photo_side', side);

      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1200,
        maxHeight: 1200,
      );

      if (photo != null) {
        await _uploadPhoto(side, photo);
        box.remove('pending_photo_side');
      }
    } catch (e) {
      ShowToaster.toasterInfo(message: 'Erro ao abrir câmera: $e');
    }
  }

  Future<void> _uploadPhoto(String side, XFile photo) async {
    await executeSafe(() async {
      final result = await CompleteProfileDocumentPhotoRepository()
          .uploadDocument(
              id: userRx.individualId!.toString(),
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
      if (documentPhotoStep?.done == true) {
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
