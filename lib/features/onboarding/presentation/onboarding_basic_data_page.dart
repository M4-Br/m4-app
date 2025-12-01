import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/geral/widgets/bottom_button.dart';
import 'package:app_flutter_miban4/features/geral/widgets/custom_textfield.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:app_flutter_miban4/features/onboarding/controller/onboarding_basic_data_controller.dart';

class OnboardingBasicDataPage extends GetView<OnboardingBasicDataController> {
  const OnboardingBasicDataPage({super.key});

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
                  'register_init'.tr,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),
          gapXL,
          AppText.bodyLarge(context, 'informations_continue'.tr),
          gapXL,
          Form(
            key: controller.formKey,
            child: Column(
              children: [
                buildCustomInput(
                  label: 'full_name'.tr,
                  hint: 'full_name'.tr,
                  controller: controller.fullNameController,
                  validator: (v) =>
                      v?.isEmpty ?? true ? 'Nome é Obrigatório' : null,
                ),
                gapM,
                buildCustomInput(
                  label: 'nickname'.tr,
                  hint: 'nickname'.tr,
                  controller: controller.usernameController,
                  validator: (v) => v?.isEmpty ?? true
                      ? 'Como quer ser chamado é Obrigatório'
                      : null,
                ),
                const SizedBox(height: AppDimens.kPaddingM),
                buildCustomInput(
                  label: 'Email',
                  hint: 'Email',
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) =>
                      v?.isEmpty ?? true ? 'Email é Obrigatório' : null,
                ),
                gapM,
                buildCustomInput(
                  label: 'promotional_code'.tr,
                  hint: 'promotional_code'.tr,
                  controller: controller.promotionalCodeController,
                ),
              ],
            ),
          ),
          const Spacer(),
          const SizedBox(height: AppDimens.kPaddingM),
          Obx(
            () => bottomButton(
              isLoading: controller.isLoading.value,
              onPressed: controller.registerBasicData,
              labelText: 'next'.tr,
              enable: controller.enable.value,
            ),
          ),
        ],
      ),
    );
  }
}
