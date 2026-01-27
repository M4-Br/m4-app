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

  @override
  void onClose() {
    passwordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.onClose();
  }

  void toggleObscure() {
    passwordObscure.value = !passwordObscure.value;
  }

  Future<void> submitChangePassword() async {
    if (!formKey.currentState!.validate()) return;

    final int password = int.parse(newPasswordController.text);

    isLoading(true);

    try {
      await _repository.changePassword(userRx.user.value!.payload.id, password);

      CustomDialogs.showInformationDialog(
        title: 'message'.tr,
        content: 'change_password_changed'.tr,
        onCancel: () {
          Get.until((route) => route.settings.name == AppRoutes.login);
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
