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
  const OnboardingDocumentPage({this.canCheck = true, super.key});

  final bool? canCheck;

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
          Spacer(),
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
          Obx(() => Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: controller.termsAccepted.value,
                    onChanged: controller.toggleTerms,
                    activeColor: const Color(0xFF065F46), // Verde M4
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: controller.openTerms,
                      child: Text.rich(
                        TextSpan(
                          text: 'Eu li e concordo com os ',
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 13),
                          children: [
                            TextSpan(
                              text: 'Termos e Condições',
                              style: const TextStyle(
                                color: Color(0xFF2563EB), // Azul de Link
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          const SizedBox(height: AppDimens.kPaddingM),
          Obx(
            () => bottomButton(
              isLoading: controller.isLoading.value,
              onPressed: controller.register,
              labelText: 'next'.tr,
              enable: controller.enable.value && controller.termsAccepted.value,
            ),
          ),
          const SizedBox(height: AppDimens.kPaddingXL),
        ],
      ),
    );
  }
}
