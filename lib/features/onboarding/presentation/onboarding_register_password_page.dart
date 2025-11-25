import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/geral/widgets/bottom_button.dart';
import 'package:app_flutter_miban4/features/geral/widgets/custom_textfield.dart';
import 'package:app_flutter_miban4/features/onboarding/controller/onboarding_password_register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingRegisterPasswordPage
    extends GetView<OnboardingPasswordRegisterController> {
  const OnboardingRegisterPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.kPaddingXL,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: controller.key,
                    child: Column(
                      children: [
                        gapXL,
                        AppText.headlineMedium(context, 'password_create'.tr),
                        gapXL,
                        AppText.bodyLarge(
                          context,
                          'password_need'.tr,
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(),
                        Obx(
                          () => buildCustomInput(
                            label: 'password'.tr,
                            hint: 'password_hint'.tr,
                            controller: controller.pswController,
                            maxLength: 6,
                            validator: (v) {
                              v?.isEmpty ?? true ? 'password_create'.tr : null;
                              v?.isNotEmpty == true && v!.length < 6
                                  ? 'password_six'.tr
                                  : null;
                              return null;
                            },
                            obscureText: controller.showPassword.value,
                            onTogglePassword: controller.toggleShowPassword,
                          ),
                        ),
                        gapM,
                        Obx(
                          () => buildCustomInput(
                            label: 'password_confirm'.tr,
                            hint: 'confirm_password_hint'.tr,
                            controller: controller.confirmPwsController,
                            maxLength: 6,
                            validator: (v) {
                              v?.isEmpty ?? true ? 'password_again'.tr : null;
                              v?.isNotEmpty == true && v!.length < 6
                                  ? 'password_six'.tr
                                  : null;
                              v?.isNotEmpty == true &&
                                      v != controller.pswController.text
                                  ? 'password_equals'.tr
                                  : null;
                              return null;
                            },
                            obscureText: controller.showPassword.value,
                            onTogglePassword: controller.toggleShowPassword,
                          ),
                        ),
                        const Spacer(),
                        gapM,
                        Obx(
                          () => bottomButton(
                            onPressed: () async => controller.register(),
                            labelText: 'next'.tr,
                            isLoading: controller.isLoading.value,
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
