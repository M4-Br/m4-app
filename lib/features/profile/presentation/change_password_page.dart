import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:app_flutter_miban4/features/profile/controller/change_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordPage extends GetView<ChangePasswordController> {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'change_app_password'.tr.toUpperCase(),
      ),
      body: CustomPageBody(
        padding: const EdgeInsets.all(AppDimens.kDefaultPadding),
        children: [
          Form(
            key: controller.formKey,
            child: Obx(() => Column(
                  children: [
                    const SizedBox(height: 32),

                    // Nova Senha
                    _buildPasswordField(
                      controller: controller.newPasswordController,
                      label: 'change_password_new'.tr,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'change_password_validate'.tr;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    _buildPasswordField(
                      controller: controller.confirmNewPasswordController,
                      label: 'change_password_new_confirm'.tr,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'change_password_validate'.tr;
                        } else if (value !=
                            controller.newPasswordController.text) {
                          return 'change_password_not_equal'.tr;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 50),
                    Obx(() => AppButton(
                          labelText: 'confirm'.tr.toUpperCase(),
                          onPressed: () async =>
                              controller.submitChangePassword(),
                          isLoading: controller.isLoading.value,
                          color: secondaryColor,
                          buttonType: AppButtonType.elevated,
                        )),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
  }) {
    // Acessando o controller da View para o obscureText
    final obscure = this.controller.passwordObscure.value;

    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(),
      obscureText: obscure,
      maxLength: 6,
      cursorColor: secondaryColor,
      validator: validator,
      style: const TextStyle(color: Colors.black, fontSize: 18),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black54, fontSize: 16),
        floatingLabelStyle:
            const TextStyle(color: secondaryColor, fontSize: 16),
        counterText: '', // Esconde contador de caracteres
        isDense: true,
        border: InputBorder.none,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black54),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: secondaryColor),
        ),
        suffixIcon: IconButton(
          onPressed: () => this.controller.toggleObscure(),
          icon: Icon(
            obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
