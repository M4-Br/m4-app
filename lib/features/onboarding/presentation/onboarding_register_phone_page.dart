import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/geral/widgets/bottom_button.dart';
import 'package:app_flutter_miban4/features/geral/widgets/custom_textfield.dart';
import 'package:app_flutter_miban4/features/onboarding/controller/onboarding_register_phone_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingRegisterPhonePage
    extends GetView<OnboardingRegisterPhoneController> {
  const OnboardingRegisterPhonePage({super.key});

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    gapXL,
                    AppText.headlineMedium(context, 'phone_register'.tr),
                    gapXL,
                    AppText.bodyMedium(context, 'for_secure_phone'.tr),
                    gapXL,
                    buildCustomInput(
                        label: 'phone'.tr,
                        hint: 'phone'.tr,
                        controller: controller.phoneController,
                        keyboardType: TextInputType.phone),
                    bottomButton(
                        onPressed: () async => controller.registerPhone(),
                        labelText: 'next'.tr),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
