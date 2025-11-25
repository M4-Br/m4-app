import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_exception.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_register_password_response.dart';
import 'package:app_flutter_miban4/features/onboarding/repository/onboarding_register_password_repository.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_dialogs.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_toaster.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingPasswordRegisterController extends GetxController {
  var isLoading = false.obs;
  final RxInt id = 0.obs;

  final RxBool showPassword = false.obs;

  final pswController = TextEditingController();
  final confirmPwsController = TextEditingController();

  final key = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      id.value = arguments['id'] ?? 0;
    }
  }

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }

  Future<OnboardingRegisterPasswordResponse?> register() async {
    if (key.currentState?.validate() != true) {
      return null;
    }
    isLoading(true);

    final int password = int.parse(confirmPwsController.text);

    try {
      final value = await OnboardingRegisterPasswordRepository()
          .registerPassword(id.value, password);

      if (value.id != 0) {
        Get.toNamed(AppRoutes.onboardingInitialRegisterDone,
            arguments: {'document': value.document});
      }

      return value;
    } catch (e, s) {
      AppLogger.I().error('Register password', e, s);
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
