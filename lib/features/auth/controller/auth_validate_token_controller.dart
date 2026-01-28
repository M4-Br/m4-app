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

  // Inicializa com 0. Usamos RxInt para ser reativo se necessário.
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
      sendToken();
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
    // Acessa os getters do UserRx (que tratam a nulidade internamente)
    final emailSalvo = userRx.userEmail;
    final idSalvo = userRx.userId;

    if (emailSalvo.isNotEmpty) {
      email.value = emailSalvo;
    }

    // Verifica se não é nulo antes de atribuir
    if (idSalvo != null && idSalvo != 0) {
      userId.value = idSalvo;
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
    // Validação de segurança: Verifica se ID e Email existem
    if (email.value.isEmpty || userId.value == 0) {
      CustomDialogs.showInformationDialog(
        content: 'Erro ao identificar usuário. Tente novamente.',
        onCancel: () => Get.back(),
      );
      return;
    }

    isLoading(true);

    try {
      startTimer();
      // CORREÇÃO AQUI: Usa .value para passar o int, não o RxInt
      await _repository.sendToken(userId.value);
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
          onCancel: () => Get.back(), // Fecha o dialog apenas
        );
      }
    } catch (e, s) {
      AppLogger.I().error('Validate Email', e, s);
    } finally {
      isLoading(false);
    }
  }
}
