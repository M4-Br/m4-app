import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/geral/widgets/bottom_button.dart';
import 'package:app_flutter_miban4/features/onboarding/controller/onboarding_initial_register_done_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OnboardingInitialRegisterDonePage
    extends GetView<OnboardingInitialRegisterDoneController> {
  const OnboardingInitialRegisterDonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.kPaddingXL,
            vertical: AppDimens.kPaddingL,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              SvgPicture.asset(
                'assets/images/miban4_colored_logo.svg',
                width: Get.width * 0.5,
              ),
              gapXL,
              AppText.headlineMedium(
                context,
                'approved'.tr,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              bottomButton(
                onPressed: () async => controller.proccedToLogin(),
                labelText: 'next'.tr,
                isLoading: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
