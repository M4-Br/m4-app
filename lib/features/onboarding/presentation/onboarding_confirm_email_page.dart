import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/geral/widgets/bottom_button.dart';
import 'package:app_flutter_miban4/features/geral/widgets/custom_textfield.dart';
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
        child: LayoutBuilder(
          builder: (context, constrains) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.kPaddingXL,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constrains.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: controller.key,
                    child: Column(
                      children: [
                        gapXL,
                        AppText.headlineLarge(context, 'email_confirm'.tr),
                        gapXL,
                        AppText.bodyLarge(
                          context,
                          textAlign: TextAlign.center,
                          'token_sent_message'.trParams({
                            'email': controller.email.value,
                          }),
                        ),
                        gapXL,
                        AppText.bodyLarge(
                            context,
                            textAlign: TextAlign.center,
                            'email_perhaps'.tr),
                        const Spacer(),
                        buildCustomInput(
                            label: 'Token',
                            hint: 'token_write'.tr,
                            controller: controller.tokenController,
                            maxLength: 6,
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'O token é necessário.';
                              }
                              if (v.length < 6) {
                                return 'O token deve ter 6 dígitos.';
                              }
                              return null;
                            }),
                        Obx(
                          () {
                            return AppButton(
                              onPressed: controller.canResend.value
                                  ? controller.resendToken
                                  : null,
                              color: controller.canResend.value
                                  ? Colors.blue
                                  : Colors.grey,
                              buttonType: AppButtonType.text,
                              labelText: controller.canResend.value
                                  ? 'resend'.tr
                                  : 'resend_in'.trParams({
                                      'seconds':
                                          controller.countdown.value.toString(),
                                    }),
                            );
                          },
                        ),
                        const Spacer(),
                        gapM,
                        bottomButton(
                          isLoading: controller.isLoading.value,
                          onPressed: () async => controller.validateEmail(),
                          labelText: 'next'.tr,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
