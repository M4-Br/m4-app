import 'dart:async';

import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_exception.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_register_phone_request.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_verify_phone_request.dart';
import 'package:app_flutter_miban4/features/onboarding/repository/onboarding_confirm_phone_repository.dart';
import 'package:app_flutter_miban4/features/onboarding/repository/onboarding_register_phone_repository.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_dialogs.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_toaster.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingConfirmPhoneController extends GetxController {
  final key = GlobalKey<FormState>();
  final tokenController = TextEditingController();

  final isLoading = false.obs;
  final enable = false.obs;

  final RxInt id = 0.obs;
  final RxString prefix = ''.obs;
  final RxString phone = ''.obs;

  final RxInt countdown = 30.obs;
  final RxBool canResend = false.obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      id.value = arguments['id'] ?? 0;
      prefix.value = arguments['prefix'] ?? '';
      phone.value = arguments['phone'] ?? '';
    }

    tokenController.addListener(_checkValidation);
    startCountdown();
  }

  @override
  void onClose() {
    tokenController.dispose();
    _timer?.cancel();
    super.onClose();
  }

  void _checkValidation() {
    enable.value = tokenController.text.length == 6;
  }

  void startCountdown() {
    canResend.value = false;
    countdown.value = 30;

    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  Future<void> resendToken() async {
    if (!canResend.value) return;

    final request = OnboardingRegisterPhone(
        id: id.value, prefix: prefix.value, phone: phone.value);

    await OnboardingRegisterPhoneRepository().registerPhone(request);

    startCountdown();
  }

  Future<void> confirmPhone() async {
    if (!enable.value) return;

    if (key.currentState?.validate() != true) {
      return;
    }

    isLoading.value = true;

    final request = OnboardingVerifyPhoneRequest(
        id: id.value,
        prefix: prefix.value,
        phone: phone.value,
        code: int.parse(tokenController.text));

    try {
      final response =
          await OnboardingConfirmPhoneRepository().confirmPhone(request);

      if (response.id != 0) {
        Get.toNamed(AppRoutes.onboardingRegisterPassword,
            arguments: {'id': id.value});
      }
    } catch (e, s) {
      AppLogger.I().error('Confirm phone token', e, s);
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
