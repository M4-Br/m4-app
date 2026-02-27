import 'dart:async';
import 'package:app_flutter_miban4/core/config/auth/controller/user_rx.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dialogs.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/auth/repository/auth_validate_token_repository.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthValidateTokenController extends GetxController {
  final UserRx userRx;
  AuthValidateTokenController(this.userRx);

  final AuthValidateTokenRepository _repository = AuthValidateTokenRepository();

  final TextEditingController tokenController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RxString email = ''.obs;

  final RxInt userId = 0.obs;

  final RxInt countdown = 60.obs;
  final RxBool canResend = false.obs;
  Timer? _timer;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
    if (userId.value != 0 && email.value.isNotEmpty) {
      _checkAndSendToken();
    } else {
      AppLogger.I().error('Tentativa de enviar token sem ID ou Email válidos.',
          Exception('Enviar token'), StackTrace.current);
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    tokenController.dispose();
    super.onClose();
  }

  void _loadUserData() {
    final emailSalvo = userRx.userEmail;
    final idSalvo = userRx.userId;

    if (emailSalvo.isNotEmpty) {
      email.value = emailSalvo;
    }
    if (idSalvo != null && idSalvo != 0) {
      userId.value = idSalvo;
    }
  }

  void startTimer() {
    canResend.value = false;
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

  Future<void> sendToken() async {
    if (email.value.isEmpty || userId.value == 0) {
      CustomDialogs.showInformationDialog(
        content: 'Erro ao identificar usuário. Tente novamente.',
        onCancel: () => Get.back(),
      );
      return;
    }

    isLoading(true);

    try {
      countdown.value = 60;
      startTimer();
      userRx.lastTokenSentTime = DateTime.now();

      await _repository.sendToken(userId.value);
    } catch (e, s) {
      AppLogger.I().error('Send Token', e, s);
    } finally {
      isLoading(false);
    }
  }

  void _checkAndSendToken() {
    if (userRx.lastTokenSentTime != null) {
      final difference = DateTime.now().difference(userRx.lastTokenSentTime!);
      final secondsPassed = difference.inSeconds;

      if (secondsPassed < 60) {
        final remaining = 60 - secondsPassed;

        countdown.value = remaining;
        canResend.value = false;
        startTimer();

        WidgetsBinding.instance.addPostFrameCallback((_) {
          ShowToaster.toasterInfo(
              message:
                  'Um token já foi enviado. Aguarde ${remaining}s para reenviar.');
        });

        return;
      }
    }

    sendToken();
  }

  Future<void> validateToken() async {
    if (!formKey.currentState!.validate()) return;
    if (userId.value == 0) {
      ShowToaster.toasterInfo(message: 'Erro de identificação do usuário.');
      return;
    }

    isLoading(true);

    try {
      final response = await _repository.validateToken(tokenController.text);

      if (response.success == true) {
        userRx.lastTokenSentTime = null;
        Get.toNamed(AppRoutes.authChangePassword);
      } else {
        CustomDialogs.showInformationDialog(
          content: 'Código inválido ou expirado.',
          onCancel: () => Get.back(),
        );
      }
    } catch (e, s) {
      AppLogger.I().error('Validate Email', e, s);
    } finally {
      isLoading(false);
    }
  }
}
