import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/strings.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/auth/controller/auth_validate_token_controller.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthValidateTokenPage extends GetView<AuthValidateTokenController> {
  const AuthValidateTokenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPageBody(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.kPaddingXL),
        children: [
          const SizedBox(height: AppDimens.kPaddingXL),
          Row(
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 24,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                child: AppText.headlineMedium(
                  context,
                  'email_confirm'.tr,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),
          const SizedBox(height: AppDimens.kPaddingXL),
          Obx(() => AppText.bodyLarge(
                context,
                textAlign: TextAlign.center,
                'token_sent_message'.trParams({
                  'email': controller.email.value.maskedEmail,
                }),
              )),
          const SizedBox(height: AppDimens.kPaddingXL),
          AppText.bodyLarge(
              context, textAlign: TextAlign.center, 'email_perhaps'.tr),
          const Spacer(),
          Form(
            key: controller.formKey,
            child: TextFormField(
              controller: controller.tokenController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, letterSpacing: 4),
              decoration: const InputDecoration(
                labelText: 'Token',
                hintText: '000000',
                counterText: '',
                labelStyle: TextStyle(color: Colors.black54, fontSize: 16),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: secondaryColor),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54),
                ),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return 'O token é necessário.';
                }
                if (v.length < 6) {
                  return 'O token deve ter 6 dígitos.';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),
          Obx(
            () {
              return AppButton(
                onPressed: controller.canResend.value
                    ? () => controller.sendToken()
                    : null,
                color:
                    controller.canResend.value ? secondaryColor : Colors.grey,
                buttonType: AppButtonType.text,
                labelText: controller.canResend.value
                    ? 'resend'.tr
                    : 'resend_in'.trParams({
                        'seconds': controller.countdown.value.toString(),
                      }),
              );
            },
          ),
          const Spacer(),
          const SizedBox(height: AppDimens.kPaddingM),
          Obx(
            () => AppButton(
              isLoading: controller.isLoading.value,
              onPressed: () => controller.validateToken(),
              labelText: 'next'.tr.toUpperCase(),
              color: secondaryColor,
              buttonType: AppButtonType.filled,
            ),
          )
        ],
      ),
    );
  }
}
