import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends BaseController {
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final RxBool passwordObscure = true.obs;

  void toggleObscure() {
    passwordObscure.value = !passwordObscure.value;
  }
}
