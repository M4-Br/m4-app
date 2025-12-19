import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/completeProfile/controller/complete_profile_document_photo_controller.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteProfileDocumentPhotoPage
    extends GetView<CompleteProfileDocumentPhotoController> {
  const CompleteProfileDocumentPhotoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: '',
        backgroundColor: Colors.white,
        iconColor: Colors.black,
        onBackPressed: () => Get.back(),
      ),
      body: CustomPageBody(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Títulos
          Center(
            child: AppText.headlineSmall(
              context,
              'every_ok'.tr,
              color: Colors.black54,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: AppText.bodyMedium(
              context,
              'plastic'.tr,
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: Get.height * 0.15),
          const Divider(height: 1, color: Colors.black12),

          Obx(() => _buildPhotoItem(
                context,
                label: 'front_photo'.tr,
                isSent: controller.isFrontSent.value,
                onTap: () {
                  if (!controller.isFrontSent.value) {
                    controller.takePhoto('front');
                  }
                },
              )),

          const Divider(height: 1, color: Colors.black12),

          Obx(() => _buildPhotoItem(
                context,
                label: 'back_photo'.tr,
                isSent: controller.isBackSent.value,
                onTap: () {
                  if (!controller.isBackSent.value) {
                    controller.takePhoto('back');
                  }
                },
              )),

          const Divider(height: 1, color: Colors.black12),
          const Spacer(),

          Obx(() => AppButton(
                labelText: 'next'.tr,
                buttonType: AppButtonType.filled,
                isLoading: controller.isLoading.value,
                color: (controller.isFrontSent.value &&
                        controller.isBackSent.value)
                    ? secondaryColor
                    : Colors.grey,
                onPressed: () async => (controller.isFrontSent.value &&
                        controller.isBackSent.value)
                    ? controller.nextStep()
                    : null,
              )),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildPhotoItem(BuildContext context,
      {required String label,
      required bool isSent,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        child: Row(
          children: [
            AppText.bodyLarge(context, label),
            const Spacer(),
            if (isSent)
              const Icon(Icons.check_circle, color: Colors.green, size: 28)
            else
              const Icon(Icons.camera_alt_outlined,
                  color: Colors.black54, size: 28),
          ],
        ),
      ),
    );
  }
}
