import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/completeProfile/controller/complete_profile_selfie_controller.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteProfileSelfiePage
    extends GetView<CompleteProfileSelfieController> {
  const CompleteProfileSelfiePage({super.key});

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
              'selfie'.tr,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: AppText.bodyMedium(
              context,
              'dont_perfect'.tr,
              textAlign: TextAlign.center,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: Get.height * 0.1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _buildInstructionItem(
                  context,
                  icon: Icons.face_retouching_off_rounded,
                  text: 'dont_gadgets'.tr,
                ),
                const SizedBox(height: 24),
                _buildInstructionItem(
                  context,
                  icon: Icons.filter_center_focus_outlined,
                  text: 'focus_photo'.tr,
                ),
                const SizedBox(height: 24),
                _buildInstructionItem(
                  context,
                  icon: Icons.visibility_outlined,
                  text: 'dont_glasses'.tr,
                ),
              ],
            ),
          ),
          const Spacer(),
          Obx(() => AppButton(
                labelText: 'understood'.tr,
                buttonType: AppButtonType.filled,
                isLoading: controller.isLoading.value,
                color: secondaryColor,
                onPressed: controller.takeSelfie,
              )),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildInstructionItem(BuildContext context,
      {required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(
          icon,
          color: secondaryColor,
          size: 32,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: AppText.bodyLarge(
            context,
            text,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
