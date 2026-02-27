import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/formatters/currency_formatter.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/core/helpers/validators.dart';
import 'package:app_flutter_miban4/features/completeProfile/controller/complete_profile_profession_controller.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:app_flutter_miban4/features/geral/widgets/custom_textfield.dart';
import 'package:app_flutter_miban4/features/geral/widgets/professions_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CompleteProfileProfessionPage
    extends GetView<CompleteProfileProfessionController> {
  const CompleteProfileProfessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: '',
        backgroundColor: Colors.white,
        iconColor: Colors.black,
        onBackPressed: () =>
            Get.until((route) => route.settings.name == AppRoutes.homeView),
      ),
      body: CustomPageBody(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: AppText.headlineSmall(
              context,
              'income_inform'.tr,
              color: Colors.black54,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          Form(
            key: controller.formKey,
            child: Column(
              children: [
                Obx(() => ProfessionsDropdown(
                      label: 'profession'.tr,
                      selectedItem: controller.selectedProfession.value,
                      onChanged: (val) =>
                          controller.selectedProfession.value = val,
                      validator: (v) => v == null ? 'Campo obrigatório' : null,
                    )),
                const SizedBox(height: 24),
                buildCustomInput(
                  label: 'income'.tr,
                  hint: '0,00', // Hint visual
                  controller: controller.incomeEc,
                  keyboardType: TextInputType.number,
                  validator: Validators.isNotEmpty,
                  formatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CurrencyFormatter(),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Obx(() => AppButton(
                labelText: 'next'.tr,
                buttonType: AppButtonType.filled,
                isLoading: controller.isLoading.value,
                color: secondaryColor,
                onPressed: controller.submitForm,
              )),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
