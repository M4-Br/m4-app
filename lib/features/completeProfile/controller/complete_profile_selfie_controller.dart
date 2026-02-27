import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/completeProfile/repository/complete_profile_selfie_repository.dart';
import 'package:app_flutter_miban4/features/profile/controller/profile_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CompleteProfileSelfieController extends BaseController {
  final ImagePicker _picker = ImagePicker();

  Future<void> takeSelfie() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 60,
        maxHeight: 1200,
        maxWidth: 1200,
      );

      if (photo != null) {
        await _uploadSelfie(photo);
      }
    } catch (e, s) {
      AppLogger.I().error('Open camera', e, s);
      ShowToaster.toasterInfo(message: 'Erro ao abrir câmera: $e');
    }
  }

  Future<void> _uploadSelfie(XFile photo) async {
    await executeSafe(() async {
      final id = userRx.individualId!.toString();

      final result = await CompleteProfileSelfieRepository()
          .sendSelfie(id: id, photo: photo);

      if (result.id != 0) {
        if (Get.isRegistered<ProfileController>()) {
          Get.find<ProfileController>().fetchSteps();
        }

        Get.toNamed(AppRoutes.completeConfirmSelfie, arguments: result);
      }
    });
  }
}
