import 'package:app_flutter_miban4/core/config/auth/controller/user_rx.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dialogs.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/profile/repository/change_password_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthChangePswController extends GetxController {
  final UserRx userRx;
  AuthChangePswController(this.userRx);

  final ChangePasswordRepository _repository = ChangePasswordRepository();

  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final RxBool passwordObscure = true.obs;

  var isLoading = false.obs;

  // Variável local para garantir que temos o ID
  int? _safeUserId;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  @override
  void onClose() {
    passwordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.onClose();
  }

  void _loadUserData() {
    // CORREÇÃO CRUCIAL:
    // Usamos userRx.userId (o getter inteligente) em vez de acessar user.value direto.
    // Isso pega o ID do 'verifyResponse' já que o login ainda não existe.
    _safeUserId = userRx.userId;

    if (_safeUserId == null || _safeUserId == 0) {
      AppLogger.I().error('ID do usuário não encontrado no UserRx',
          Exception('User ID Null'), StackTrace.current);
      // Opcional: Você pode forçar a saída da tela se não tiver ID
    }
  }

  void toggleObscure() {
    passwordObscure.value = !passwordObscure.value;
  }

  Future<void> submitChangePassword() async {
    if (!formKey.currentState!.validate()) return;

    // Validação de segurança antes de chamar a API
    if (_safeUserId == null || _safeUserId == 0) {
      ShowToaster.toasterInfo(
          message: 'Erro ao identificar o usuário. Reinicie o processo.');
      return;
    }

    // Nota: Verifique se sua API espera int ou String.
    // Mantive int.parse conforme seu código original.
    final int password = int.parse(newPasswordController.text);

    isLoading(true);

    try {
      // Passamos a variável segura _safeUserId! (que já checamos não ser nula acima)
      await _repository.changePassword(_safeUserId!, password);

      CustomDialogs.showInformationDialog(
        title: 'message'.tr,
        content: 'change_password_changed'.tr,
        onCancel: () {
          // Mudei para onConfirm (botão OK)
          Get.back(); // Fecha o Dialog
          // Limpa toda a pilha e volta pro login para obrigar o usuário a logar com a senha nova
          Get.offAllNamed(AppRoutes.login);
        },
      );
    } catch (e, s) {
      AppLogger.I().error('Auth Change Password', e, s);
      ShowToaster.toasterInfo(message: e.toString());
    } finally {
      isLoading(false);
    }
  }
}
