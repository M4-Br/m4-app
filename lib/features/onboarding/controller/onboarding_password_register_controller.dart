import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_exception.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_register_password_response.dart';
import 'package:app_flutter_miban4/features/onboarding/repository/onboarding_register_password_repository.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingPasswordRegisterController extends GetxController {
  final key = GlobalKey<FormState>();
  final pswController = TextEditingController();
  final confirmPwsController = TextEditingController();

  final isLoading = false.obs;
  final enable = false.obs;
  final RxBool showPassword = false.obs;

  final RxInt id = 0.obs;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      id.value = arguments['id'] ?? 0;
    }

    pswController.addListener(_checkValidation);
    confirmPwsController.addListener(_checkValidation);
  }

  @override
  void onClose() {
    pswController.dispose();
    confirmPwsController.dispose();
    super.onClose();
  }

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void _checkValidation() {
    final p1 = pswController.text;
    final p2 = confirmPwsController.text;

    final isValid = p1.length == 6 && p2.length == 6 && p1 == p2;

    enable.value = isValid;
  }

  Future<OnboardingRegisterPasswordResponse?> register() async {
    if (!enable.value) return null;

    if (key.currentState?.validate() != true) {
      return null;
    }

    isLoading.value = true;

    try {
      final int password = int.parse(confirmPwsController.text);

      final value = await OnboardingRegisterPasswordRepository()
          .registerPassword(id.value, password);

      Get.toNamed(AppRoutes.onboardingInitialRegisterDone,
          arguments: {'document': value.document});

      return value;
    } catch (e, s) {
      AppLogger.I().error('Register password', e, s);
      if (e is ApiException) {
        if (e.statusCode == 500) {
          CustomDialogs.showInformationDialog(
              content: 'Verifique sua conexão e tente novamente mais tarde.',
              onCancel: () => Get.offAllNamed(AppRoutes.splash));
        }
      }
      return null;
    } finally {
      isLoading.value = false;
    }
  }
}
