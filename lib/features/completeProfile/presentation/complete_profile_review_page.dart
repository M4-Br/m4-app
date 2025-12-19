import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/completeProfile/controller/complete_profile_in_review_controller.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CompleteProfileReviewPage
    extends GetView<CompleteProfileReviewController> {
  const CompleteProfileReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomPageBody(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          SvgPicture.asset(
            'assets/images/m4_logo_colored.svg',
            width: 180,
          ),
          const SizedBox(height: 40),
          AppText.headlineSmall(
            context,
            'analysis_progress'.tr,
            color: Colors.black87,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AppText.bodyLarge(
              context,
              'request_sent'.tr,
              color: Colors.black54,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 60),
          AppText.bodySmall(
            context,
            'know_more'.tr,
            color: Colors.black54,
          ),
          const Spacer(),
          SizedBox(
            width: 200,
            child: AppButton(
              labelText: 'want'.tr,
              buttonType: AppButtonType.filled,
              color: secondaryColor,
              onPressed: () => controller.openMoreInfo(),
            ),
          ),
          const SizedBox(height: 20),
          AppButton(
            labelText: 'Voltar para Home',
            buttonType: AppButtonType.text,
            color: Colors.black, // Cor do texto
            onPressed: () async => controller.goToHome(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
