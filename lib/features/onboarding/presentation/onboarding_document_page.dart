import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/data/util/helpers/mask.dart';
import 'package:app_flutter_miban4/features/geral/widgets/bottom_button.dart';
import 'package:app_flutter_miban4/features/geral/widgets/custom_textfield.dart';
import 'package:app_flutter_miban4/features/onboarding/controller/onboarding_document_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingDocumentPage extends GetView<OnboardingDocumentController> {
  const OnboardingDocumentPage({super.key});

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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            gapXL, // Espaço do topo
                            AppText.headlineMedium(context, 'welcome'.tr),
                            gapXL,
                            AppText.bodyLarge(context, 'insert_cpf'.tr),
                          ],
                        ),
                        buildCustomInput(
                          label: 'CPF',
                          hint: 'insert_cpf'.tr,
                          controller: controller.documentController,
                          keyboardType: TextInputType.number,
                          formatters: [cpfMaskFormatter],
                          validator: (v) =>
                              v?.isEmpty ?? true ? 'CPF obrigatório' : null,
                        ),
                        bottomButton(
                          isLoading: controller.isLoading.value,
                          onPressed: () async => controller.register(),
                          labelText: 'next'.tr,
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
