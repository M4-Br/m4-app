import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/geral/widgets/bottom_button.dart';
import 'package:app_flutter_miban4/features/geral/widgets/custom_textfield.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:app_flutter_miban4/features/onboarding/controller/onboarding_password_register_controller.dart';

class OnboardingRegisterPasswordPage
    extends GetView<OnboardingPasswordRegisterController> {
  const OnboardingRegisterPasswordPage({super.key});

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
                  'password_create'.tr,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),

          const SizedBox(height: AppDimens.kPaddingXL),

          AppText.bodyLarge(
            context,
            'password_need'.tr,
            textAlign: TextAlign.center,
          ),

          const Spacer(),

          // Form
          Form(
            key: controller.key,
            child: Column(
              children: [
                Obx(
                  () => buildCustomInput(
                    label: 'password'.tr,
                    hint: 'password_hint'.tr,
                    controller: controller.pswController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'password_required'.tr;
                      }
                      if (v.length < 6) {
                        return 'password_six'.tr;
                      }
                      return null;
                    },
                    obscureText: !controller.showPassword.value,
                    onTogglePassword: controller.toggleShowPassword,
                  ),
                ),
                const SizedBox(height: AppDimens.kPaddingM),
                Obx(
                  () => buildCustomInput(
                    label: 'password_confirm'.tr,
                    hint: 'confirm_password_hint'.tr,
                    controller: controller.confirmPwsController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'password_required'.tr;
                      }
                      if (v.length < 6) {
                        return 'validator_six_char'.tr;
                      }
                      if (v != controller.pswController.text) {
                        return 'validator_password_confirm'.tr;
                      }
                      return null;
                    },
                    obscureText: !controller.showPassword.value,
                    onTogglePassword: controller.toggleShowPassword,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),
          const SizedBox(height: AppDimens.kPaddingM),

          Obx(
            () => bottomButton(
              onPressed: controller.register,
              labelText: 'next'.tr,
              isLoading: controller.isLoading.value,
              enable: controller.enable.value,
            ),
          ),
        ],
      ),
    );
  }
}
