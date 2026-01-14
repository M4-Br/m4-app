import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/completeProfile/controller/complete_profile_selfie_confirm_controller.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteProfileConfirmSelfiePage
    extends GetView<CompleteProfileConfirmSelfieController> {
  const CompleteProfileConfirmSelfiePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: '',
        backgroundColor: Colors.white,
        showBackButton: false,
      ),
      body: CustomPageBody(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (controller.imageBytes != null)
            Container(
              constraints: BoxConstraints(
                maxHeight: Get.height * 0.5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
                image: DecorationImage(
                  image: MemoryImage(controller.imageBytes!),
                  fit: BoxFit.cover,
                ),
              ),
            )
          else
            const Center(
                child: CircularProgressIndicator(color: secondaryColor)),
          const SizedBox(height: 24),
          Center(
            child: AppText.bodyLarge(
              context,
              'onboarding_confirm_selfie'.tr,
              textAlign: TextAlign.center,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  labelText: 'onboarding_confirm_again'.tr.toUpperCase(),
                  buttonType: AppButtonType.outlined,
                  color: Colors.black,
                  onPressed: () async => controller.retakePhoto(),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppButton(
                  labelText: 'onboarding_confirm_cool'.tr.toUpperCase(),
                  buttonType: AppButtonType.filled,
                  color: secondaryColor,
                  onPressed: () async => controller.confirmPhoto(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
