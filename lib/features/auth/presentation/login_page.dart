import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/config/auth/controller/verify_user_controller.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/validators.dart';
import 'package:app_flutter_miban4/features/auth/presentation/widgets/language_selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_shifter_v2/mask_shifter.dart';

class LoginPage extends GetView<VerifyAccountController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fundo alterado para Branco
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const LanguageSelectorWidget(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.kPaddingXL,
                      ),
                      child: SizedBox(
                        width: 200,
                        child: Image.asset(
                          'assets/images/yooconn.png',
                          width: 120,
                          // Removido o color: Colors.white para exibir as cores originais
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.kPaddingXL,
                      ),
                      child: Form(
                        key: controller.formKey,
                        child: TextFormField(
                          cursorColor: primaryColor, // Cursor na cor primária
                          controller: controller.document,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 20), // Texto digitado escuro
                          inputFormatters: [
                            MaskedTextInputFormatterShifter(
                                maskONE: 'XXX.XXX.XXX-XX',
                                maskTWO: 'XX.XXX.XXX/XXXX-XX'),
                          ],
                          validator: Validators.isNotEmpty,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey
                                      .shade400), // Linha inferior cinza claro
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: primaryColor,
                                  width: 2), // Linha primária quando focado
                            ),
                            contentPadding: EdgeInsets.zero,
                            labelText: 'cpf'.tr,
                            labelStyle: TextStyle(
                              color: Colors.grey.shade600, // Label cinza escuro
                              fontSize: 16,
                            ),
                            floatingLabelStyle: TextStyle(
                              color:
                                  primaryColor, // Label primário quando flutuando
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.kPaddingXL,
                      ),
                      child: Obx(
                        () => AppButton(
                          isLoading: controller.isLoading.value,
                          labelText: 'access'.tr,
                          onPressed: () => controller.authVerify(),
                          buttonType: AppButtonType
                              .filled, // Mudei para Filled (preenchido) para dar contraste no fundo branco
                          color: primaryColor, // Botão na cor primária
                        ),
                      ),
                    ),
                    Obx(() {
                      if (controller.canCheckBiometrics.value) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: InkWell(
                            onTap: () => controller.loginWithBiometrics(),
                            child: Column(
                              children: [
                                Icon(Icons.fingerprint,
                                    size: 50,
                                    color:
                                        primaryColor), // Ícone na cor primária
                                const SizedBox(height: 5),
                                Text(
                                  'Entrar com digital',
                                  style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 12), // Texto cinza escuro
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                    Align(
                      alignment: Alignment.center,
                      child: AppButton(
                        onPressed: () async =>
                            Get.toNamed(AppRoutes.privacyPolicyFromLogin),
                        buttonType: AppButtonType.text,
                        color: Colors.grey.shade700, // Texto cinza escuro
                        labelText: 'terms'.tr,
                      ),
                    ),
                    AppButton(
                      labelText: 'register'.tr,
                      onPressed: () async {
                        Get.toNamed(AppRoutes.onboardingDocument);
                      },
                      buttonType: AppButtonType
                          .outlined, // Mudei para Outline para diferenciar do botão "Acessar"
                      color: primaryColor, // Cor primária no contorno
                    ),
                    const SizedBox(height: 16), // Um espaço extra no final
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
