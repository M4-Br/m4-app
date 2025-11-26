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
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constrains.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: controller.key,
                    child: Column(
                      children: [
                        gapXL,
                        AppText.headlineLarge(context, 'phone_confirm'.tr),
                        gapXL,
                        AppText.bodyLarge(
                          context,
                          'email_send_code'.tr,
                          textAlign: TextAlign.center,
                        ),
                        gapXL,
                        AppText.bodyLarge(
                          context,
                          'email_perhaps'.tr,
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(),
                        buildCustomInput(
                            label: 'Token',
                            hint: 'token_write'.tr,
                            controller: controller.tokenController,
                            keyboardType: TextInputType.number,
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
                        Obx(
                          () => bottomButton(
                            isLoading: controller.isLoading.value,
                            onPressed: () async => controller.confirmPhone(),
                            labelText: 'next'.tr,
                          ),
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
