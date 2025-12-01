import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_exception.dart';
import 'package:app_flutter_miban4/features/onboarding/repository/onboarding_document_repository.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_dialogs.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_toaster.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OnboardingDocumentController extends GetxController {
  final key = GlobalKey<FormState>();
  final documentController = TextEditingController();

  final isLoading = false.obs;
  final enable = false.obs;

  @override
  void onInit() {
    super.onInit();
    documentController.addListener(_checkValidation);
  }

  @override
  void onClose() {
    documentController.dispose();
    super.onClose();
  }

  void _checkValidation() {
    enable.value = documentController.text.length == 14;
  }

  Future<void> register() async {
    if (!enable.value) return;

    if (key.currentState?.validate() != true) {
      return;
    }

    isLoading.value = true;

    final doc = documentController.text.replaceAll('.', '').replaceAll('-', '');

    try {
      final response = await OnboardingDocumentRepository().basicRegister(doc);

      if (response.id != 0) {
        Get.toNamed(AppRoutes.onboardingBasicData,
            arguments: {'id': response.id});
      }
    } catch (e, s) {
      AppLogger.I().error('Cpf initial register', e, s);
      if (e is ApiException) {
        if (e.statusCode == 500) {
          CustomDialogs.showInformationDialog(
              content: 'Verifique sua conexão e tente novamente mais tarde.',
              onCancel: () => Get.offAllNamed(AppRoutes.splash));
        } else {
          ShowToaster.toasterInfo(
            message: e.message,
            isError: true,
          );
        }
      }
    } finally {
      isLoading.value = false;
    }
  }
}
