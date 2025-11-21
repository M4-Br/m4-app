import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/data/util/helpers/mask.dart';
import 'package:app_flutter_miban4/features/onboarding/controller/onboarding_one_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OnboardingOnePage extends GetView<OnboardingOneController> {
  const OnboardingOnePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.kPaddingXL, vertical: AppDimens.kPaddingL),
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                gapXL,
                AppText.headlineMedium(context, 'welcome'.tr),
                gapXL,
                AppText.bodyLarge(context, 'insert_cpf'.tr),
                gapXL,
                _buildCustomInput(
                  label: 'CPF',
                  hint: 'Digite seu CPF',
                  controller: controller.documentController,
                  keyboardType: TextInputType.text,
                  formatters: [cpfMaskFormatter],
                  validator: (v) =>
                      v?.isEmpty ?? true ? 'CPF obrigatório' : null,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.kDefaultPadding,
            vertical: AppDimens.kPaddingL),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: AppButton(
            onPressed: () async => controller.register(),
            labelText: 'CONTINUAR',
            buttonType: AppButtonType.filled,
          ),
        ),
      ),
    );
  }

  Widget _buildCustomInput({
    required String label,
    required String hint,
    required TextEditingController controller,
    List<TextInputFormatter>? formatters,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      inputFormatters: formatters,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Colors.black87, width: 1.5),
        ),
      ),
    );
  }
}
