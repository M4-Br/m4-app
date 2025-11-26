import 'package:app_flutter_miban4/core/helpers/formatters/formatters.dart';
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
                child: IntrinsicHeight(
                  child: Form(
                    key: controller.key,
                    child: Column(
                      children: [
                        gapXL,
                        AppText.headlineMedium(context, 'phone_register'.tr),
                        gapXL,
                        AppText.bodyLarge(
                          context,
                          'for_secure_phone'.tr,
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(),
                        buildCustomInput(
                          label: 'phone'.tr,
                          hint: 'phone'.tr,
                          controller: controller.phoneController,
                          formatters: [phoneFormatter],
                          keyboardType: TextInputType.phone,
                          validator: (v) =>
                              v?.isEmpty ?? true ? 'phone_required'.tr : null,
                        ),
                        const Spacer(),
                        Obx(
                          () => bottomButton(
                            isLoading: controller.isLoading.value,
                            onPressed: () async => controller.registerPhone(),
                            labelText: 'next'.tr,
                          ),
                        ),
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
