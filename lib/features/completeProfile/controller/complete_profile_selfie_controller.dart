import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/completeProfile/repository/complete_profile_selfie_repository.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';

class CompleteProfileSelfieController extends BaseController {
  final ImagePicker _picker = ImagePicker();

  Future<void> takeSelfie() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 50,
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
      final id = userRx.user.value!.payload.id.toString();

      final result = await CompleteProfileSelfieRepository()
          .sendSelfie(id: id, photo: photo);

      if (result.id != 0) {
        Get.toNamed(AppRoutes.completeConfirmSelfie, arguments: result);
      }
    });
  }
}
