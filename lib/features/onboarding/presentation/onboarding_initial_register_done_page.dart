import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/geral/widgets/bottom_button.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:app_flutter_miban4/features/onboarding/controller/onboarding_initial_register_done_controller.dart';

class OnboardingInitialRegisterDonePage
    extends GetView<OnboardingInitialRegisterDoneController> {
  const OnboardingInitialRegisterDonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomPageBody(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.kPaddingXL,
          vertical: AppDimens.kPaddingL,
        ),
        children: [
          const Spacer(),
          SvgPicture.asset(
            'assets/images/m4_logo_colored.svg',
            width: Get.width * 0.5,
          ),
          const SizedBox(height: AppDimens.kPaddingXL), // gapXL
          AppText.headlineMedium(
            context,
            'approved'.tr,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          bottomButton(
            onPressed: controller.proccedToLogin,
            labelText: 'next'.tr,
            isLoading: false,
            enable: true,
          ),
        ],
      ),
    );
  }
}
