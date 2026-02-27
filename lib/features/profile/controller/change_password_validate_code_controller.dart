import 'dart:async';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dialogs.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/profile/repository/change_password_verify_repository.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordValidateCodeController extends BaseController {
  final ChangePasswordVerifyRepository _repository =
      ChangePasswordVerifyRepository();

  final TextEditingController tokenController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RxString email = ''.obs;

  int? _safeUserId;

  final RxInt countdown = 60.obs;
  final RxBool canResend = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();

    if (email.value.isNotEmpty && _safeUserId != null && _safeUserId != 0) {
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
    final safeEmail = userRx.userEmail;
    final safeId = userRx.userId;

    if (safeEmail.isNotEmpty) {
      email.value = safeEmail;
    }

    if (safeId != null && safeId != 0) {
      _safeUserId = safeId;
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
    if (email.value.isEmpty || _safeUserId == null) return;

    await executeSafe(() async {
      countdown.value = 60;
      startTimer();

      userRx.lastTokenSentTime = DateTime.now();
      await _repository.sendToken(_safeUserId!);
    });
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

    if (_safeUserId == null) {
      ShowToaster.toasterInfo(message: 'Erro de identificação do usuário.');
      return;
    }

    await executeSafe(() async {
      final response = await _repository.validateToken(tokenController.text);

      if (response.success == true) {
        userRx.lastTokenSentTime = null;
        Get.toNamed(AppRoutes.changePasswordFromProfile);
      } else {
        CustomDialogs.showInformationDialog(
          content: 'Código inválido ou expirado.',
          onCancel: () => Get.back(),
        );
      }
    });
  }
}
