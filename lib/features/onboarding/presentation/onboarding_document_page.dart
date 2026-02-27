import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/core/helpers/formatters/mask.dart';
import 'package:app_flutter_miban4/features/geral/widgets/bottom_button.dart';
import 'package:app_flutter_miban4/features/geral/widgets/custom_textfield.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:app_flutter_miban4/features/onboarding/controller/onboarding_document_controller.dart';

class OnboardingDocumentPage extends GetView<OnboardingDocumentController> {
  const OnboardingDocumentPage({super.key});

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
                  'welcome'.tr,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),
          const SizedBox(height: AppDimens.kPaddingXL),
          AppText.bodyLarge(context, 'insert_cpf'.tr),
          const SizedBox(height: AppDimens.kPaddingXL),
          Form(
            key: controller.key,
            child: buildCustomInput(
              label: 'CPF',
              hint: 'insert_cpf'.tr,
              controller: controller.documentController,
              keyboardType: TextInputType.number,
              formatters: [cpfMaskFormatter],
              validator: (v) => v?.isEmpty ?? true ? 'CPF obrigatório' : null,
            ),
          ),
          const Spacer(),
          const SizedBox(height: AppDimens.kPaddingM),
          Obx(
            () => bottomButton(
              isLoading: controller.isLoading.value,
              onPressed: controller.register,
              labelText: 'next'.tr,
              enable: controller.enable.value,
            ),
          ),
        ],
      ),
    );
  }
}
