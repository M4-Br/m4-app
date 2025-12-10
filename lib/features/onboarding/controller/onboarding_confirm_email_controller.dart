import 'dart:async';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_exception.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_basic_register_request.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_verify_email_request.dart';
import 'package:app_flutter_miban4/features/onboarding/repository/onboarding_basic_register_repository.dart';
import 'package:app_flutter_miban4/features/onboarding/repository/onboarding_verfy_email_token_repository.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dialogs.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OnboardingConfirmEmailController extends GetxController {
  final key = GlobalKey<FormState>();
  final tokenController = TextEditingController();

  final isLoading = false.obs;
  final enable = false.obs;

  final RxInt id = 0.obs;
  final RxString email = ''.obs;
  final RxString fullName = ''.obs;
  final RxString userName = ''.obs;

  final RxInt countdown = 30.obs;
  final RxBool canResend = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      id.value = arguments['id'] ?? 0;
      email.value = arguments['email'] ?? '';
      fullName.value = arguments['fullName'] ?? '';
      userName.value = arguments['username'] ?? '';
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

    final request = OnboardingBasicRegisterRequest(
        id: id.value,
        fullName: fullName.value,
        username: userName.value,
        email: email.value,
        promotionalCode: null);

    await OnboardingBasicRegisterRepository().basicRegister(request);
    startCountdown();
  }

  Future<void> validateEmail() async {
    if (!enable.value) return;

    if (key.currentState?.validate() != true) {
      return;
    }

    isLoading.value = true;

    try {
      final request = OnboardingVerifyEmailRequest(
        id: id.value,
        fullName: fullName.value,
        username: userName.value,
        email: email.value,
        promotionalCode: null,
        code: int.parse(tokenController.text),
      );

      await OnboardingVerifyEmailTokenRepository().validateToken(request);
      Get.toNamed(AppRoutes.onboardingPhone, arguments: {'id': id.value});
    } catch (e, s) {
      AppLogger.I().error('Confirm email token', e, s);
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
