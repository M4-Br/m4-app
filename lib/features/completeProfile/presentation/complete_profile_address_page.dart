import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/data/util/helpers/mask.dart';
import 'package:app_flutter_miban4/data/util/helpers/validators.dart';
import 'package:app_flutter_miban4/features/completeProfile/controller/complete_profile_address_controller.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:app_flutter_miban4/features/geral/widgets/brazilian_states_dropdown.dart';
import 'package:app_flutter_miban4/features/geral/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteProfileAddressPage
    extends GetView<CompleteProfileAddressController> {
  const CompleteProfileAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Endereço',
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
              'full_address_information'.tr,
              color: Colors.black54,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          Form(
            key: controller.formKey,
            child: Column(
              children: [
                // 1. CEP
                buildCustomInput(
                  label: 'address_cep'.tr,
                  hint: '00000-000',
                  controller: controller.cepEc,
                  keyboardType: TextInputType.number,
                  formatters: [cepMaskFormatter],
                  validator: Validators.isNotEmpty,
                  maxLength: 9,
                ),
                const SizedBox(height: 16),
                Obx(() => DropdownButtonFormField<String>(
                      initialValue: controller.selectedResType.value,
                      hint: Text('address_type'.tr),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black87, width: 1.5)),
                        errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                      ),
                      items: controller.residentialTypes.map((String item) {
                        return DropdownMenuItem<String>(
                            value: item, child: Text(item));
                      }).toList(),
                      onChanged: (v) => controller.selectedResType.value = v,
                      validator: (v) => v == null ? 'Campo obrigatório' : null,
                    )),
                const SizedBox(height: 16),
                buildCustomInput(
                  label: 'address'.tr,
                  hint: '',
                  controller: controller.addressEc,
                  validator: Validators.isNotEmpty,
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: buildCustomInput(
                        label: 'address_number'.tr,
                        hint: '',
                        controller: controller.numberEc,
                        keyboardType: TextInputType.number,
                        validator: (v) => controller.isNoNumberChecked.value
                            ? null
                            : Validators.isNotEmpty(v),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Obx(() => Row(
                          children: [
                            Checkbox(
                              activeColor: secondaryColor,
                              value: controller.isNoNumberChecked.value,
                              onChanged: controller.toggleNoNumber,
                            ),
                            AppText.bodyMedium(context, 'address_no_number'.tr,
                                maxLines: 1),
                          ],
                        )),
                  ],
                ),
                const SizedBox(height: 16),
                buildCustomInput(
                  label: 'address_complement'.tr,
                  hint: '',
                  controller: controller.complementEc,
                ),
                const SizedBox(height: 16),
                buildCustomInput(
                  label: 'address_neighborhood'.tr,
                  hint: '',
                  controller: controller.neighborhoodEc,
                  validator: Validators.isNotEmpty,
                ),
                const SizedBox(height: 16),
                Obx(() => StatesDropdown(
                      selectedState: controller.selectedState.value,
                      onChanged: (val) => controller.selectedState.value = val,
                      label: 'address_state'.tr,
                    )),
                const SizedBox(height: 16),
                buildCustomInput(
                  label: 'address_city'.tr,
                  hint: '',
                  controller: controller.cityEc,
                  validator: Validators.isNotEmpty,
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
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
