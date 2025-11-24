import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/features/onboarding/controller/onboarding_document_controller.dart';
import 'package:get/get.dart';

class OnboardingDocumentBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingDocumentController>(
        () => OnboardingDocumentController());

    AppLogger.I().info('Onboarding Step one bindings injected');
  }
}
