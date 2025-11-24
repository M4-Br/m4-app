import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/geral/widgets/bottom_button.dart';
import 'package:app_flutter_miban4/features/geral/widgets/custom_textfield.dart';
import 'package:app_flutter_miban4/features/onboarding/controller/onboarding_basic_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingBasicDataPage extends GetView<OnboardingBasicDataController> {
  const OnboardingBasicDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: LayoutBuilder(builder: (context, constrains) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.kPaddingXL,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constrains.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                gapXL,
                AppText.headlineMedium(context, 'register_init'.tr),
                gapXL,
                AppText.bodyLarge(context, 'informations_continue'.tr),
                gapXL,
                Form(
                  key: controller.key,
                  child: Column(
                    children: [
                      buildCustomInput(
                        label: 'full_name'.tr,
                        hint: 'full_name'.tr,
                        controller: controller.nameController,
                        validator: (v) =>
                            v?.isEmpty ?? true ? 'Nome é Obrigatório' : null,
                      ),
                      buildCustomInput(
                        label: 'nickname'.tr,
                        hint: 'nickname'.tr,
                        controller: controller.usernameController,
                        validator: (v) => v?.isEmpty ?? true
                            ? 'Como quer ser chamado é Obrigatório'
                            : null,
                      ),
                      buildCustomInput(
                        label: 'Email',
                        hint: 'Email',
                        controller: controller.emailController,
                        validator: (v) =>
                            v?.isEmpty ?? true ? 'Email é Obrigatório' : null,
                      ),
                      buildCustomInput(
                        label: 'promotional_code'.tr,
                        hint: 'promotional_code'.tr,
                        controller: controller.promotionalCodeController,
                      ),
                    ],
                  ),
                ),
                bottomButton(
                  onPressed: () async => controller.registerBasicData(),
                  labelText: 'next'.tr,
                ),
              ],
            ),
          ),
        );
      })),
    );
  }
}
