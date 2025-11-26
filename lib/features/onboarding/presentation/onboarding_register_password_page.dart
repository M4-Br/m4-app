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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                  onTap: () => Get.back(),
                                  child: Container(
                                    color: Colors.transparent,
                                    child: const Icon(
                                      Icons.arrow_back_ios_new,
                                      size: 24,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: AppText.headlineMedium(
                                  context,
                                  'password_create'.tr,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ]),
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
                              if (v == null || v.isEmpty) {
                                return 'password_required'.tr;
                              }
                              if (v.length < 6) {
                                return 'password_six'.tr;
                              }
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
