import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/core/helpers/formatters/mask.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:app_flutter_miban4/features/pix/keyManager/controller/pix_add_new_key_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PixAddNewKeyPage extends GetView<PixAddNewKeyController> {
  const PixAddNewKeyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe9eaf0),
      appBar: CustomAppBar(
        title: 'pix_registerNewKey'.tr,
        onBackPressed: controller.backToManager,
      ),
      body: CustomPageBody(
        padding: const EdgeInsets.all(AppDimens.kDefaultPadding),
        children: [
          const SizedBox(height: 16),
          Center(
            child: AppText.bodyLarge(
              context,
              'pix_registerKey_inform'.tr,
              textAlign: TextAlign.center,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: Obx(() => DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: controller.selectedDropdown.value,
                    hint: Text('pix_choose_new'.tr),
                    isExpanded: true,
                    items: controller.dropdownOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: controller.onDropdownChanged,
                  ),
                )),
          ),
          const SizedBox(height: 24),
          Obx(() {
            final type = controller.selectedDropdown.value;
            final user = controller.userRx.user.value?.payload;

            if (type == null) return const SizedBox.shrink();

            return Column(
              children: [
                if (type == 'CPF / CNPJ' && user != null)
                  _buildOptionCard(
                    context,
                    iconPath: 'assets/icons/ic_pix_person.png',
                    text: MaskUtil.applyMask(user.document, '###.###.###-##'),
                    isSelected: controller.selectedKeyType.value == 'document',
                    onTap: () => controller.selectOption(
                        type: 'document', value: user.document),
                  ),
                if (type == 'pix_phone'.tr) ...[
                  _buildOptionCard(
                    context,
                    iconPath: 'assets/icons/ic_add_content.png',
                    text: 'pix_anotherNumber'.tr,
                    isSelected: controller.selectedKeyType.value == 'phone' &&
                        controller.selectedKeyValue.value ==
                            controller.manualInputController.text &&
                        controller.manualInputController.text.isNotEmpty,
                    onTap: () => controller.openManualEntrySheet('phone'),
                  ),
                ],
                if (type == 'Email' && user != null) ...[
                  _buildOptionCard(
                    context,
                    iconPath: 'assets/icons/ic_add_content.png',
                    text: 'pix_anotherEmail'.tr,
                    isSelected: controller.selectedKeyType.value == 'email' &&
                        controller.selectedKeyValue.value ==
                            controller.manualInputController.text &&
                        controller.manualInputController.text.isNotEmpty,
                    onTap: () => controller.openManualEntrySheet('email'),
                  ),
                  const SizedBox(height: 16),
                  _buildOptionCard(
                    context,
                    iconPath: 'assets/icons/ic_pix_email.png',
                    text: user.email,
                    isSelected: controller.selectedKeyType.value == 'email' &&
                        controller.selectedKeyValue.value == user.email,
                    onTap: () => controller.selectOption(
                        type: 'email', value: user.email),
                  ),
                ],
                if (type == 'pix_randomKeyRegister'.tr)
                  _buildOptionCard(
                    context,
                    iconPath: 'assets/icons/ic_pix_random_key.png',
                    text: 'pix_randomKeyRegister'.tr,
                    isSelected: controller.selectedKeyType.value == 'evp',
                    onTap: () =>
                        controller.selectOption(type: 'evp', value: ''),
                  ),
              ],
            );
          }),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  labelText: 'cancel'.tr.toUpperCase(),
                  onPressed: () async => controller.backToManager(),
                  buttonType: AppButtonType.filled,
                  color: Colors.grey.shade400,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Obx(() {
                  // Só habilita se tiver um tipo selecionado
                  final canRegister =
                      controller.selectedKeyType.value.isNotEmpty;

                  return AppButton(
                    labelText: 'register_button'.tr.toUpperCase(),
                    isLoading: controller.isLoading.value,
                    color: secondaryColor,
                    onPressed: () async =>
                        canRegister ? controller.openPasswordDialog : null,
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildOptionCard(
    BuildContext context, {
    required String iconPath,
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade300, // Cor de fundo do card
          border: isSelected
              ? Border.all(color: secondaryColor, width: 2)
              : Border.all(color: Colors.transparent, width: 2),
        ),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              width: 30,
              color: Colors.black87,
              errorBuilder: (c, e, s) =>
                  const Icon(Icons.star, color: Colors.black87),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: secondaryColor),
          ],
        ),
      ),
    );
  }
}
