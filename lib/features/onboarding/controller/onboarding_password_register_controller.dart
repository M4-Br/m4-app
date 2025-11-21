import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_exception.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_register_password_response.dart';
import 'package:app_flutter_miban4/features/onboarding/repository/onboarding_register_password_repository.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_toaster.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingPasswordRegisterController extends GetxController {
  var isLoading = false.obs;
  final RxInt id = 0.obs;

  final pswController = TextEditingController();
  final confirmPwsController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      id.value = arguments['id'] ?? 0;
    }
  }

  Future<OnboardingRegisterPasswordResponse> register() async {
    isLoading(true);

    final int password = int.parse(confirmPwsController.text);

    try {
      final value = await OnboardingRegisterPasswordRepository()
          .registerPassword(id.value, password);

      return value;
    } on ApiException catch (e) {
      ShowToaster.toasterInfo(message: e.message);
      rethrow;
    } catch (e, s) {
      AppLogger.I().error('Register password', e, s);
      ShowToaster.toasterInfo(message: e.toString());
      rethrow;
    } finally {
      isLoading(false);
    }
  }
}
