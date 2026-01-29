import 'package:app_flutter_miban4/core/config/log/logger.dart'; // Import para logs de segurança
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dialogs.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/profile/repository/change_password_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends BaseController {
  final ChangePasswordRepository _repository = ChangePasswordRepository();

  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final RxBool passwordObscure = true.obs;

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
  }

  void toggleObscure() {
    passwordObscure.value = !passwordObscure.value;
  }

  Future<void> submitChangePassword() async {
    if (!formKey.currentState!.validate()) return;

    if (_safeUserId == null || _safeUserId == 0) {
      ShowToaster.toasterInfo(message: 'Erro ao identificar usuário.');
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
          'Erro ao verificar Step 8 no ChangePasswordController. Assumindo completed=false.',
          e,
          s);
      completed = false;
    }

    await executeSafe(() async {
      await _repository.changePassword(_safeUserId!, password, completed);

      CustomDialogs.showInformationDialog(
        title: 'message'.tr,
        content: 'change_password_changed'.tr,
        onCancel: () {
          Get.until((route) => route.settings.name == AppRoutes.homeView);
        },
      );
    });
  }
}
