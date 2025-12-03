import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/strings.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/pix/copyPaste/controller/pix_copy_paste_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PixCopyPastePage extends GetView<PixCopyPasteController> {
  const PixCopyPastePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'pix_copyAndPaste'.tr,
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_2_outlined, color: Colors.white),
            onPressed: controller.goToCamera,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            AppText.bodyLarge(
              context,
              'pix_pasteCode'.tr,
              color: Colors.black87,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.codeController,
              maxLines: 3,
              minLines: 1,
              decoration: InputDecoration(
                labelText: 'pix_code'.tr,
                labelStyle: const TextStyle(color: Colors.grey),
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
            ),
            const Spacer(),
            Center(
              child: Obx(() => Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: "${'balance_available'.tr}: "),
                        TextSpan(
                          text: controller.balanceRx.balance.value?.balanceCents
                              .toBRL(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  )),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    labelText: 'cancel'.tr.toUpperCase(),
                    onPressed: () async => Get.back(),
                    buttonType: AppButtonType.filled,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Obx(() => AppButton(
                        labelText: 'proceed'.tr,
                        isLoading: controller.isLoading.value,
                        onPressed: () async => controller.isButtonEnabled.value
                            ? controller.decodeCopyPaste()
                            : null,
                        color: controller.buttonColor,
                      )),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
