import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/geral/widgets/bottom_button.dart';
import 'package:app_flutter_miban4/features/geral/widgets/custom_textfield.dart';
import 'package:app_flutter_miban4/features/onboarding/controller/onboarding_confirm_phone_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingConfirmPhonePage
    extends GetView<OnboardingConfirmPhoneController> {
  const OnboardingConfirmPhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constrains) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.kPaddingXL,
                  vertical: AppDimens.kPaddingL),
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constrains.maxHeight),
                child: Form(
                  key: controller.key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      gapXL,
                      AppText.headlineLarge(context, 'phone_confirm'.tr),
                      gapXL,
                      AppText.bodyLarge(context, 'email_send_code'.tr),
                      gapXL,
                      AppText.bodyLarge(context, 'email_perhaps'.tr),
                      gapXL,
                      buildCustomInput(
                          label: 'Token',
                          hint: 'token_write'.tr,
                          controller: controller.tokenController,
                          keyboardType: TextInputType.number,
                          maxLength: 6),
                      Obx(
                        () {
                          return AppButton(
                            onPressed: controller.canResend.value
                                ? controller.resendToken
                                : null,
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
                      bottomButton(
                          onPressed: () async => controller.confirmPhone(),
                          labelText: 'next'.tr)
                    ],
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
