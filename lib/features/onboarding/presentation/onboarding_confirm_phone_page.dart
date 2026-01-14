import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/geral/widgets/bottom_button.dart';
import 'package:app_flutter_miban4/features/geral/widgets/custom_textfield.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:app_flutter_miban4/features/onboarding/controller/onboarding_confirm_phone_controller.dart';

class OnboardingConfirmPhonePage
    extends GetView<OnboardingConfirmPhoneController> {
  const OnboardingConfirmPhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPageBody(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.kPaddingXL),
        children: [
          const SizedBox(height: AppDimens.kPaddingXL),
          Row(
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 24,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                child: AppText.headlineMedium(
                  context,
                  'phone_confirm'.tr,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),
          const SizedBox(height: AppDimens.kPaddingXL),
          AppText.bodyLarge(
            context,
            'email_send_code'.tr,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimens.kPaddingXL),
          AppText.bodyLarge(
            context,
            'email_perhaps'.tr,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Form(
            key: controller.key,
            child: buildCustomInput(
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
          ),
          Obx(
            () {
              return AppButton(
                onPressed:
                    controller.canResend.value ? controller.resendToken : null,
                color: controller.canResend.value ? Colors.blue : Colors.grey,
                buttonType: AppButtonType.text,
                labelText: controller.canResend.value
                    ? 'resend'.tr
                    : 'resend_in'.trParams({
                        'seconds': controller.countdown.value.toString(),
                      }),
              );
            },
          ),
          const Spacer(),
          const SizedBox(height: AppDimens.kPaddingM),
          Obx(
            () => bottomButton(
              isLoading: controller.isLoading.value,
              onPressed: controller.confirmPhone,
              labelText: 'next'.tr,
              enable: controller.enable.value,
            ),
          )
        ],
      ),
    );
  }
}
