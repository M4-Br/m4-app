import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/core/helpers/formatters/formatters.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/geral/widgets/bottom_button.dart';
import 'package:app_flutter_miban4/features/geral/widgets/custom_textfield.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:app_flutter_miban4/features/onboarding/controller/onboarding_register_phone_controller.dart';

class OnboardingRegisterPhonePage
    extends GetView<OnboardingRegisterPhoneController> {
  const OnboardingRegisterPhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPageBody(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.kPaddingXL),
        children: [
          const SizedBox(height: AppDimens.kPaddingXL),
          // Header
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
                  'phone_register'.tr,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),

          const SizedBox(height: AppDimens.kPaddingXL),

          AppText.bodyLarge(
            context,
            'for_secure_phone'.tr,
            textAlign: TextAlign.center,
          ),

          const Spacer(),

          Form(
            key: controller.key,
            child: buildCustomInput(
              label: 'phone'.tr,
              hint: 'phone'.tr,
              controller: controller.phoneController,
              formatters: [phoneFormatter],
              keyboardType: TextInputType.phone,
              validator: (v) => v?.isEmpty ?? true ? 'phone_required'.tr : null,
            ),
          ),

          const Spacer(),
          const SizedBox(height: AppDimens.kPaddingM),

          Obx(
            () => bottomButton(
              isLoading: controller.isLoading.value,
              onPressed: controller.registerPhone,
              labelText: 'next'.tr,
              enable: controller.enable.value,
            ),
          ),
        ],
      ),
    );
  }
}
