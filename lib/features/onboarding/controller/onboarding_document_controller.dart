import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_exception.dart';
import 'package:app_flutter_miban4/features/onboarding/repository/onboarding_document_repository.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dialogs.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class OnboardingDocumentController extends GetxController {
  final key = GlobalKey<FormState>();
  final documentController = TextEditingController();

  final isLoading = false.obs;
  final enable = false.obs;

  final RxBool termsAccepted = false.obs;
  final RxBool hasReadTerms = false.obs;

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

    if (!documentController.text.isCpf) {
      ShowToaster.toasterInfo(message: 'Digite um CPF Válido');
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

  Future<void> openTerms() async {
    // 1. Marca que ele já clicou para ler, liberando o Checkbox
    hasReadTerms.value = true;

    const String url = 'https://yooconn-m4.lovable.app/documents/terms';
    const String title = 'Termos e Condições';

    // 2. Abre híbrido (Web Launcher ou WebView Mobile)
    if (kIsWeb) {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } else {
      Get.toNamed(AppRoutes.webView, arguments: {
        // Confirme se a rota é essa no seu app_routes
        'url': url,
        'title': title,
      });
    }
  }

  void toggleTerms(bool? value) {
    if (!hasReadTerms.value) {
      Get.snackbar(
        'Atenção',
        'Por favor, leia os Termos e Condições primeiro clicando no link.',
        backgroundColor: Colors.orange.shade100,
        colorText: Colors.orange.shade900,
      );
      return;
    }
    termsAccepted.value = value ?? false;

    // Se você tiver uma função que revalida o botão (ex: checkForm()), chame ela aqui:
    // checkForm();
  }
}
