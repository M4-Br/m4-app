import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:app_flutter_miban4/features/pix/pixWithKey/controller/pix_with_key_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PixWithKeyPage extends GetView<PixWithKeyController> {
  const PixWithKeyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'pix_withKey'.tr,
        onBackPressed: controller.backToHome,
      ),
      body: CustomPageBody(
        padding: const EdgeInsets.all(AppDimens.kDefaultPadding),
        children: [
          const SizedBox(height: 16),
          Center(
            child: AppText.titleMedium(
              context,
              'pix_addReceiverKey'.tr,
            ),
          ),
          const SizedBox(height: 24),
          AppText.bodyLarge(context, 'pix_keyType'.tr),
          const SizedBox(height: 8),
          Obx(() => DropdownButtonFormField<String>(
                initialValue: controller.selectedType.value,
                hint: const Text('Selecione um tipo'),
                isExpanded: true,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                ),
                items: controller.keyTypes.entries.map((entry) {
                  return DropdownMenuItem<String>(
                    value: entry.key,
                    child: Text(entry.value),
                  );
                }).toList(),
                onChanged: controller.onTypeChanged,
              )),
          const SizedBox(height: 16),
          TextField(
            controller: controller.keyController,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              labelText: 'pix_labelKey'.tr,
              border: const UnderlineInputBorder(),
              labelStyle: const TextStyle(color: Colors.black54),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 45,
            child: Obx(
              () => AppButton(
                onPressed: () async {
                  controller.isButtonEnabled.value
                      ? controller.searchKey()
                      : null;
                },
                labelText: 'pix_search'.tr,
                color: controller.buttonColor,
                isLoading: controller.isLoading.value,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
