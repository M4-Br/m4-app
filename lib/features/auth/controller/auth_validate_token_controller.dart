import 'dart:async';
import 'package:app_flutter_miban4/core/config/auth/controller/user_rx.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dialogs.dart';
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

  final RxInt countdown = 60.obs;
  final RxBool canResend = false.obs;
  Timer? _timer;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserEmail();
    sendToken();
  }

  @override
  void onClose() {
    _timer?.cancel();
    tokenController.dispose();
    super.onClose();
  }

  void _loadUserEmail() {
    final emailSalvo = userRx.userEmail;

    if (emailSalvo.isNotEmpty) {
      email.value = emailSalvo;
    } else {
      // Opcional: Tratar caso o email não venha de lugar nenhum
      // Ex: Voltar para tela anterior
    }
  }

  void startTimer() {
    countdown.value = 60;
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
    if (email.value.isEmpty) return;

    isLoading(true);

    try {
      startTimer();
      await _repository.sendToken(userRx.user.value!.payload.userId!);
    } catch (e, s) {
      AppLogger.I().error('Send Token', e, s);
    } finally {
      isLoading(false);
    }
  }

  Future<void> validateToken() async {
    if (!formKey.currentState!.validate()) return;

    isLoading(true);

    try {
      final response = await _repository.validateToken(tokenController.text);

      if (response.success == true) {
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
