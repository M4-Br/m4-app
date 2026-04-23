import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/config/auth/controller/auth_controller.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordPage extends GetView<AuthController> {
  const PasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white, // Fundo branco
        body: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 32, left: 32),
                          child: SafeArea(
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: GestureDetector(
                                child: const Icon(
                                  Icons.arrow_back_ios_new_outlined,
                                  color:
                                      Colors.black87, // Ícone de voltar escuro
                                  size: 24,
                                ),
                                onTap: () => Get.back(),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 32, 0, 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/yooconn.png',
                                height: 150,
                              ),
                              const SizedBox(width: 16),
                              Image.asset(
                                'assets/images/m4_ic_logo.png',
                                height: 60,
                                color: primaryColor,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(32, 55, 32, 50),
                          child: Obx(
                            () => TextFormField(
                              cursorColor: primaryColor, // Cursor primário
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return 'password_required'.tr;
                                }
                                if (v.length < 6) {
                                  return 'password_six'.tr;
                                }
                                return null;
                              },
                              controller: controller.password,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 20), // Texto digitado escuro
                              obscureText: controller.obscureText.value,
                              maxLength: 6,
                              decoration: InputDecoration(
                                counterText: '',
                                isDense: true,
                                border: InputBorder.none,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey
                                          .shade400), // Linha inferior cinza
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: primaryColor,
                                      width: 2), // Linha focada primária
                                ),
                                contentPadding: EdgeInsets.zero,
                                labelText: 'password'.tr,
                                labelStyle: TextStyle(
                                  color: Colors
                                      .grey.shade600, // Label cinza escuro
                                  fontSize: 16,
                                ),
                                floatingLabelStyle: TextStyle(
                                  color:
                                      primaryColor, // Label flutuante primário
                                  fontSize: 16,
                                ),
                                hintText: '',
                                suffixIcon: Obx(
                                  () => IconButton(
                                    onPressed: () =>
                                        controller.toggleObscureText(),
                                    icon: Icon(
                                      controller.obscureText.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.grey
                                          .shade600, // Ícone do olho em cinza
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(32, 30, 32, 50),
                          child: Obx(() => AppButton(
                                isLoading: controller.isLoading.value,
                                onPressed: () => controller.authLogin(),
                                buttonType: AppButtonType
                                    .filled, // Botão preenchido para dar destaque
                                labelText: 'access'.tr,
                                color: primaryColor, // Cor primária no botão
                              )),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: AppButton(
                            onPressed: () async =>
                                Get.toNamed(AppRoutes.authValidateToken),
                            buttonType: AppButtonType
                                .outlined, // Outlined para ação secundária
                            labelText: 'forgot_password'.tr,
                            color:
                                primaryColor, // Borda e texto com a cor primária
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ));
  }
}
