import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/completeProfile/model/complete_profile_response.dart';
import 'package:get/get.dart';

class RedirectCompleteProfileController {
  Future<dynamic> handleRedirect(CompleteProfileResponse response) async {
    if (response.steps.isEmpty) {
      AppLogger.I().error('Auth Redirect',
          Exception('Usuário sem steps definidos'), StackTrace.current);
      return;
    }
    for (var step in response.steps) {
      if (!step.done) {
        AppLogger.I().info(
            'Step incompleto encontrado. Redirecionando para: [${step.stepId}] - ${step.name}');
        _navigateToStep(step.stepId);
        return;
      }
    }

    AppLogger.I()
        .info('Todos os steps concluídos. Redirecionando para Home/Login.');
    Get.offAllNamed(AppRoutes.homeView);
  }

  static void _navigateToStep(int stepId) {
    switch (stepId) {
      case 2:
      case 3:
        Get.toNamed(AppRoutes.completeAddress);
        break;

      case 4:
        Get.toNamed(AppRoutes.completeProfession);
        break;

      case 5:
        Get.toNamed(AppRoutes.completePersonalData);
        break;

      case 6:
        Get.toNamed(AppRoutes.completeDocumentChoose);
        break;

      case 7:
        Get.toNamed(AppRoutes.completeDocumentPhotoSelfie);
        break;

      case 8:
        Get.toNamed(AppRoutes.completeSelfie);
        break;

      default:
        AppLogger.I().error('Complete Profile Redirect Redirect',
            Exception('Step ID desconhecido: $stepId'), StackTrace.current);
    }
  }
}
