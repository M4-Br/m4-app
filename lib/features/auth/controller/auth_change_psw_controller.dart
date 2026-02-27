import 'package:app_flutter_miban4/core/config/auth/controller/user_rx.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dialogs.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/auth/repository/auth_change_psw_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthChangePswController extends GetxController {
  final UserRx userRx;
  AuthChangePswController(this.userRx);

  final AuthChangePswRepository _repository = AuthChangePswRepository();

  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final RxBool passwordObscure = true.obs;

  var isLoading = false.obs;

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
    _safeUserId = userRx.individualId;

    if (_safeUserId == null || _safeUserId == 0) {
      AppLogger.I().error('ID do usuário não encontrado',
          Exception('User ID Null'), StackTrace.current);
    }
  }

  void toggleObscure() {
    passwordObscure.value = !passwordObscure.value;
  }

  Future<void> submitChangePassword() async {
    if (!formKey.currentState!.validate()) return;

    if (_safeUserId == null || _safeUserId == 0) {
      ShowToaster.toasterInfo(
          message: 'Erro ao identificar o usuário. Reinicie o processo.');
      return;
    }

    final String password = newPasswordController.text;
    bool completed = false;

    try {
      final steps = userRx.userSteps;
      final step8 = steps.firstWhere((step) => step.id == 8,
          orElse: () => throw Exception('Step 8 not found'));
      completed = !step8.done;
    } catch (e, s) {
      AppLogger.I().error(
          'Step 8 (Selfie) não encontrado na lista. Assumindo completed = false.',
          e,
          s);
      completed = false;
    }

    isLoading(true);

    try {
      await _repository.changePassword(_safeUserId!, password, completed);

      CustomDialogs.showInformationDialog(
        title: 'message'.tr,
        content: 'change_password_changed'.tr,
        onCancel: () {
          Get.back();
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
