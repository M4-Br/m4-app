import 'dart:convert';
import 'dart:typed_data';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/completeProfile/model/complete_profile_selfie_response.dart';
import 'package:get/get.dart';

class CompleteProfileConfirmSelfieController extends BaseController {
  Uint8List? imageBytes;

  @override
  void onInit() {
    super.onInit();
    _loadArguments();
  }

  void _loadArguments() {
    final args = Get.arguments;

    if (args != null && args is CompleteProfileSelfieResponse) {
      try {
        imageBytes = base64Decode(args.base64);
      } catch (e, s) {
        AppLogger.I().error('Confirm Selfie Page', e, s);
        Get.back();
        ShowToaster.toasterInfo(
            message: 'Não foi possível processar a imagem. Tente novamente');
      }
    } else {
      Get.back();
    }
  }

  void retakePhoto() {
    Get.back();
  }

  void confirmPhoto() {
    Get.toNamed(AppRoutes.completeInReview);
  }
}
