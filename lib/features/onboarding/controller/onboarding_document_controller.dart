import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_exception.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_document_register_response.dart';
import 'package:app_flutter_miban4/features/onboarding/repository/onboarding_document_repository.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_dialogs.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_toaster.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OnboardingDocumentController extends GetxController {
  var isLoading = false.obs;
  final key = GlobalKey<FormState>();

  final documentController = TextEditingController();

  Future<OnboardingDocumentRegisterResponse?> register() async {
    if (key.currentState?.validate() != true) {
      return null;
    }
    isLoading(true);

    final doc = documentController.text.replaceAll('.', '').replaceAll('-', '');
    try {
      final response = await OnboardingDocumentRepository().basicRegister(doc);

      if (response.id != 0) {
        Get.toNamed(AppRoutes.onboardingBasicData,
            arguments: {'id': response.id});
        return response;
      }

      return response;
    } catch (e, s) {
      AppLogger.I().error('Cpf initial register', e, s);
      if (e is ApiException) {
        if (e.statusCode == 500) {
          CustomDialogs.showInformationDialog(
              content: e.message,
              onCancel: () => Get.offAllNamed(AppRoutes.splash));
        } else {
          ShowToaster.toasterInfo(message: e.message);
        }
      }
      return null;
    } finally {
      isLoading(false);
    }
  }
}
