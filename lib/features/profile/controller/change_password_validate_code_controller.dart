import 'dart:async';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dialogs.dart';
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

  final RxInt countdown = 60.obs;
  final RxBool canResend = false.obs;
  Timer? _timer;

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
    final userEmail = userRx.user.value?.payload.email;
    if (userEmail != null) {
      email.value = userEmail;
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

    await executeSafe(() async {
      startTimer();
      await _repository.sendToken(userRx.user.value!.payload.userId!);
    });
  }

  Future<void> validateToken() async {
    if (!formKey.currentState!.validate()) return;

    await executeSafe(() async {
      final response = await _repository.validateToken(tokenController.text);

      if (response.success == true) {
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
