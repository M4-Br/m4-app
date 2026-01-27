import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/core/helpers/formatters/mask.dart';
import 'package:app_flutter_miban4/core/helpers/validators.dart';
import 'package:app_flutter_miban4/features/completeProfile/controller/complete_profile_personal_data_controller.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:app_flutter_miban4/features/geral/widgets/brazilian_states_dropdown.dart';
import 'package:app_flutter_miban4/features/geral/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteProfilePersonalDataPage
    extends GetView<CompleteProfilePersonalDataController> {
  const CompleteProfilePersonalDataPage({super.key});

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
        enableIntrinsicHeight: false,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: AppText.headlineSmall(
              context,
              'personal_data'.tr,
              color: Colors.black54,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: AppText.bodyMedium(
              context,
              'pay_attention'.tr,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          Form(
            key: controller.formKey,
            child: Column(
              children: [
                buildCustomInput(
                  label: 'document_name'.tr,
                  hint: '',
                  controller: controller.nameEc,
                  validator: (v) => Validators.combine([
                    () => Validators.isNotEmpty(v),
                    () => Validators.hasMinChars(v, 3),
                  ]),
                ),
                const SizedBox(height: 16),
                buildCustomInput(
                  label: 'document_mother_name'.tr,
                  hint: '',
                  controller: controller.motherNameEc,
                  validator: (v) => Validators.combine([
                    () => Validators.isNotEmpty(v),
                    () => Validators.hasMinChars(v, 3),
                  ]),
                ),
                const SizedBox(height: 16),
                Obx(() => _buildDropdown(
                      label: 'document_gender'.tr,
                      value: controller.selectedGender.value,
                      items: controller.genderOptions,
                      onChanged: (v) => controller.selectedGender.value = v,
                    )),
                const SizedBox(height: 16),
                buildCustomInput(
                  label: 'document_birthday'.tr,
                  hint: 'DD/MM/AAAA',
                  controller: controller.birthDateEc,
                  keyboardType: TextInputType.number,
                  formatters: [birthMaskFormatter],
                  validator: Validators.isOfLegalAge,
                  maxLength: 10,
                ),
                const SizedBox(height: 16),
                Obx(() => _buildDropdown(
                      label: 'document_marital_status'.tr,
                      value: controller.selectedMaritalStatus.value,
                      items: controller.maritalOptions,
                      onChanged: (v) =>
                          controller.selectedMaritalStatus.value = v,
                    )),
                const SizedBox(height: 16),
                Obx(() => _buildDropdown(
                      label: 'document_nationality'.tr,
                      value: controller.selectedNationality.value,
                      items: controller.nationalityOptions,
                      onChanged: (v) =>
                          controller.selectedNationality.value = v,
                    )),
                const SizedBox(height: 16),
                buildCustomInput(
                  label: 'document_rg'.tr,
                  hint: '',
                  controller: controller.rgNumberEc,
                  keyboardType: TextInputType.number,
                  formatters: [rgMaskFormatter],
                  validator: Validators.isNotEmpty,
                  maxLength: 12,
                ),
                const SizedBox(height: 16),
                Obx(() => StatesDropdown(
                      label: 'document_state'.tr,
                      selectedState: controller.selectedRgState.value,
                      onChanged: (v) => controller.selectedRgState.value = v,
                    )),
                const SizedBox(height: 16),
                buildCustomInput(
                  label: 'document_rgEmission'.tr,
                  hint: 'Ex: SSP',
                  controller: controller.rgIssuerEc,
                  validator: Validators.isNotEmpty,
                ),
                const SizedBox(height: 16),
                buildCustomInput(
                  label: 'document_rg_date'.tr,
                  hint: 'DD/MM/AAAA',
                  controller: controller.rgDateEc,
                  keyboardType: TextInputType.number,
                  formatters: [birthMaskFormatter],
                  validator: Validators.isNotEmpty,
                  maxLength: 10,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    AppText.bodyMedium(context, 'document_pep'.tr),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _showPepDialog(context),
                      child: const Icon(Icons.info_outline_rounded,
                          color: Colors.grey),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Obx(() => _buildDropdown(
                      label: 'Selecione',
                      value: controller.selectedPepOption.value,
                      items: controller.pepOptions,
                      onChanged: controller.setPepOption,
                    )),
                Obx(() => Visibility(
                      visible: controller.isPep.value,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: buildCustomInput(
                          label: 'document_pep_date'.tr,
                          hint: 'DD/MM/AAAA',
                          controller: controller.pepDateEc,
                          keyboardType: TextInputType.number,
                          formatters: [birthMaskFormatter],
                          validator: (v) => controller.isPep.value
                              ? Validators.isNotEmpty(v)
                              : null,
                          maxLength: 10,
                        ),
                      ),
                    )),
              ],
            ),
          ),
          const SizedBox(height: 32),
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

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      hint: Text(label),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 12),
        isDense: true,
        border:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black87, width: 1.5)),
        errorBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      ),
      items: items.map((String item) {
        return DropdownMenuItem<String>(value: item, child: Text(item));
      }).toList(),
      onChanged: onChanged,
      validator: (v) => v == null ? 'Campo obrigatório' : null,
    );
  }

  void _showPepDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppText.bodyMedium(
            context,
            'pep'.tr,
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          Center(
            child: SizedBox(
              width: 120,
              child: AppButton(
                labelText: 'OK',
                buttonType: AppButtonType.filled,
                color: secondaryColor,
                onPressed: () async => Get.back(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
