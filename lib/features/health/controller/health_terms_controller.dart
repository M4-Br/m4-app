import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HealthTermsController extends BaseController {
  final _storage = GetStorage();
  final _secureStorage = const FlutterSecureStorage();

  final String _storageKey = 'mock_melife_contracted';
  final String _storagePlanKey = 'mock_melife_plan_name';

  final RxBool isAccepted = false.obs;
  final passwordController = TextEditingController();

  late String selectedPlan;

  @override
  void onInit() {
    super.onInit();
    // Recebe o plano vindo da tela anterior
    selectedPlan = Get.arguments['planName'] ?? 'MeLife Essencial';
  }

  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }

  void toggleAccepted(bool? value) {
    isAccepted.value = value ?? false;
  }

  Future<void> verifyPasswordAndContract() async {
    final inputPassword = passwordController.text;

    if (inputPassword.isEmpty) {
      ShowToaster.toasterInfo(
          message: 'Por favor, digite sua senha.', isError: true);
      return;
    }

    isLoading.value = true;

    try {
      // 1. Busca a senha real no Secure Storage
      final String? savedPassword =
          await _secureStorage.read(key: 'user_password');

      // 2. Compara (Simulação de validação de segurança)
      await Future.delayed(const Duration(seconds: 2)); // Simula processamento

      if (inputPassword == savedPassword) {
        // 3. Salva o status de contratado localmente
        _storage.write(_storageKey, true);
        _storage.write(_storagePlanKey, selectedPlan);

        isLoading.value = false;

        // Limpa a pilha de telas e volta para a Home da MeLife ativa
        Get.until((route) => route.settings.name == AppRoutes.healthHome);
        ShowToaster.toasterInfo(message: 'Plano contratado com sucesso!');
      } else {
        isLoading.value = false;
        ShowToaster.toasterInfo(
            message: 'Senha incorreta. Tente novamente.', isError: true);
      }
    } catch (e) {
      isLoading.value = false;
      ShowToaster.toasterInfo(
          message: 'Erro ao validar segurança.', isError: true);
    }
  }
}
