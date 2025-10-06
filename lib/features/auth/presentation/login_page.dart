import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/config/auth/controller/verify_user_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/data/util/helpers/validators.dart';
import 'package:app_flutter_miban4/features/auth/presentation/widgets/language_selector_widget.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_screen.dart';
import 'package:app_flutter_miban4/ui/screens/politics/privacy_policy_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_shifter_v2/mask_shifter.dart';

class LoginPage extends GetView<VerifyAccountController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const LanguageSelectorWidget(),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
            child: SizedBox(
              width: 200,
              child: Image.asset(
                'assets/images/ic_default_logo.png',
                width: 120,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 50, 32, 50),
            child: Form(
              key: controller.formKey,
              child: TextFormField(
                cursorColor: Colors.white,
                controller: controller.document,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white, fontSize: 20),
                inputFormatters: [
                  MaskedTextInputFormatterShifter(
                      maskONE: "XXX.XXX.XXX-XX", maskTWO: "XX.XXX.XXX/XXXX-XX"),
                ],
                validator: Validators.isNotEmpty,
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  contentPadding: EdgeInsets.zero,
                  labelText: 'cpf'.tr,
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 0, 32, 50),
            child: Obx(
              () => AppButton(
                isLoading: controller.isLoading.value,
                labelText: 'access'.tr,
                onPressed: () => controller.authVerify(),
                buttonType: AppButtonType.outlined,
                color: Colors.white,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: AppButton(
              onPressed: () async => Get.to(() => const PrivacyPolicyPage(),
                  transition: Transition.rightToLeft),
              buttonType: AppButtonType.text,
              color: Colors.white,
              labelText: 'terms'.tr,
            ),
          ),
          AppButton(
            labelText: 'register'.tr,
            onPressed: () async {
              Get.to(
                () => const OnboardingPage(),
                transition: Transition.rightToLeft,
              );
            },
            buttonType: AppButtonType.filled,
            color: thirdColor,
          ),
        ],
      ),
    );
  }
}
