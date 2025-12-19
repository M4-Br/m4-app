import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/completeProfile/controller/complete_profile_document_selfie_controller.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteProfileSelfieDocumentPage
    extends GetView<CompleteProfileSelfieDocumentController> {
  const CompleteProfileSelfieDocumentPage({super.key});

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
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/images/document_selfie.png',
              height: 150,
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: AppText.headlineSmall(
              context,
              'take_document_selfie'.tr,
              color: Colors.black54,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          _buildInstructionItem(context, number: '1', text: 'selfie_one'.tr),
          const SizedBox(height: 16),
          _buildInstructionItem(context, number: '2', text: 'selfie_two'.tr),
          const SizedBox(height: 16),
          _buildInstructionItem(context, number: '3', text: 'selfie_three'.tr),
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
      {required String number, required String text}) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: secondaryColor,
          ),
          child: Center(
            child: AppText.bodyLarge(
              context,
              number,
              color: Colors.white,
              bold: true,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: AppText.bodyMedium(
            context,
            text,
            maxLines: 3,
          ),
        ),
      ],
    );
  }
}
