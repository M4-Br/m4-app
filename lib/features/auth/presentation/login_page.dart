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
      backgroundColor: primaryColor,
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
                          'assets/images/m4_ic_logo.png',
                          width: 120,
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
                          cursorColor: Colors.white,
                          controller: controller.document,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          inputFormatters: [
                            MaskedTextInputFormatterShifter(
                                maskONE: 'XXX.XXX.XXX-XX',
                                maskTWO: 'XX.XXX.XXX/XXXX-XX'),
                          ],
                          validator: Validators.isNotEmpty,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            contentPadding: EdgeInsets.zero,
                            labelText: 'cpf'.tr,
                            labelStyle: const TextStyle(
                              color: Colors.white,
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
                          buttonType: AppButtonType.outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Obx(() {
                      if (controller.canCheckBiometrics.value) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(top: 20.0), // Espaçamento
                          child: InkWell(
                            onTap: () => controller.loginWithBiometrics(),
                            child: const Column(
                              children: [
                                Icon(Icons.fingerprint,
                                    size: 50, color: Colors.white),
                                SizedBox(height: 5),
                                Text(
                                  'Entrar com digital',
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return const SizedBox
                          .shrink(); // Não mostra nada se não tiver biometria
                    }),
                    Align(
                      alignment: Alignment.center,
                      child: AppButton(
                        onPressed: () async =>
                            Get.toNamed(AppRoutes.privacyPolicyFromLogin),
                        buttonType: AppButtonType.text,
                        color: Colors.white,
                        labelText: 'terms'.tr,
                      ),
                    ),
                    AppButton(
                      labelText: 'register'.tr,
                      onPressed: () async {
                        Get.toNamed(AppRoutes.onboardingDocument);
                      },
                      buttonType: AppButtonType.filled,
                      color: thirdColor,
                    ),
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
