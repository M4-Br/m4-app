import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/onboarding/controller/onboarding_confirm_email_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingConfirmEmailPage
    extends GetView<OnboardingConfirmEmailController> {
  const OnboardingConfirmEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.kPaddingXL, vertical: AppDimens.kPaddingL),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                gapXL,
                AppText.headlineLarge(context, 'Confirme seu e-mail'),
                gapXL,
                AppText.bodyLarge(context,
                    'Enviamos um token para ${controller.email}. Por favor, digite o token recebido para confirmar seu -email.'),
                gapXL,
                TextFormField(
                  controller: controller.tokenController,
                  keyboardType: const TextInputType.numberWithOptions(),
                  validator: (v) {
                    v?.isEmpty ?? true ? 'Telefone obrigatório' : null;
                    controller.tokenController.text.length > 5
                        ? null
                        : 'O token contem 6 números';
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Token',
                    hintText: 'Token recebido por e-mail',
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide:
                          const BorderSide(color: Colors.black87, width: 1.5),
                    ),
                  ),
                ),
                Obx(() {
                  return AppButton(
                    onPressed: controller.canResend.value
                        ? controller.resendToken
                        : null,
                    buttonType: AppButtonType.text,
                    labelText: controller.canResend.value
                        ? 'Reenviar'
                        : 'Reenviar em ${controller.countdown.value}s',
                  );
                })
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.kDefaultPadding,
            vertical: AppDimens.kPaddingL),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: AppButton(
            onPressed: () async => controller.sendToken(),
            labelText: 'CONTINUAR',
            buttonType: AppButtonType.filled,
          ),
        ),
      ),
    );
  }
}
