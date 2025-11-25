import 'package:app_flutter_miban4/core/config/auth/model/verify_user_response.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/ui/screens/login/code_validate/code_validate_page.dart';
import 'package:get/get.dart';

class AuthRedirect {
  static void handleRedirect(VerifyUserResponse response) {
    // PJ no primeiro acesso
    if (response.documentType == 'PJ' &&
        response.document.length > 11 &&
        response.firstAccess) {
      AppLogger.I()
          .info('PJ no primeiro acesso, redirecionando para CodeValidatePage');
      Get.to(() => const CodeValidatePage(page: 1),
          transition: Transition.rightToLeft);

      return;
    }

    // Usuário já cadastrado
    if (!response.firstAccess) {
      AppLogger.I()
          .info('Usuário já cadastrado, redirecionando para PasswordPage');
      Get.toNamed(AppRoutes.password);
      return;
    }

    //Apenas documento preenchido
    if (response.document.isNotEmpty && response.email?.isEmpty == true) {
      AppLogger.I().info(
          'Usuário com documento preenchido mas email vazio, redirecionando para OnboardingBasicDataPage');
      Get.toNamed(AppRoutes.onboardingBasicData,
          arguments: {'id': response.id});
      return;
    }

    // Cadastro aprovado e último passo concluído
    if (response.steps.last.done && response.steps.isNotEmpty) {
      AppLogger.I().info('Cadastro aprovado, redirecionando para PasswordPage');
      Get.toNamed(AppRoutes.password);

      return;
    }

    // Navegação dinâmica pelos steps
    for (var step in response.steps) {
      if (!step.done) {
        AppLogger.I()
            .info('Redirecionando para o step: ${step.id} - ${step.name}');
        _navigateToStep(step.id, response.id);
        return;
      }
    }

    // Status pendente ou aprovado mas último passo não concluído
    if (!response.steps.last.done) {
      if (response.steps.last.id == 9 && !response.steps.last.done) {
        // Step 9 equivale à tela de revisão
        if (response.steps.last.done == false && response.steps.last.id == 9) {
          AppLogger.I().info(
              'Cadastro em revisão, redirecionando para OnboardingInReviewPage');
          Get.toNamed(AppRoutes.onboardingReview);
        } else {
          AppLogger.I().info(
              'Cadastro aprovado, redirecionando para OnboardingApprovedPage');
          Get.toNamed(AppRoutes.onboardingApproved);
        }
        return;
      }
    }
    AppLogger.I().error('Auth Redirect', Exception('Resposta inválida da API'),
        StackTrace.current, {'response': response.toString()});
    throw Exception('Resposta inválida da API');
  }

  /// Mapeia o step_id para a página correta
  static void _navigateToStep(int stepId, dynamic userId) {
    switch (stepId) {
      case 1:
        Get.toNamed(AppRoutes.onboardingBasicData, arguments: {'id': userId});
        break;
      case 2:
        Get.toNamed(AppRoutes.onboardingPhone, arguments: {'id': userId});
        break;
      case 9:
        Get.toNamed(AppRoutes.onboardingRegisterPassword,
            arguments: {'id': userId});
        break;
      default:
        throw Exception('Step desconhecido: $stepId');
    }
  }

  static void login() async {
    AppLogger.I().info('Login success, fetching icons');

    AppLogger.I().info('Login feito, redirecionando para Home Page');
    Get.offAllNamed(AppRoutes.homeView);
  }
}
