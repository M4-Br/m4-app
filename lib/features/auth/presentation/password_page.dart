import 'package:app_flutter_miban4/core/config/auth/controller/auth_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/data/util/helpers/validators.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/screens/login/code_validate/code_validate_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordPage extends GetView<AuthController> {
  const PasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      resizeToAvoidBottomInset: false,
      body: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32, left: 32),
              child: SafeArea(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    child: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.white,
                      size: 24,
                    ),
                    onTap: () => Get.back(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 32, 0, 50),
              child: SizedBox(
                width: 200,
                child: Image.asset('assets/images/ic_default_logo.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 55, 32, 50),
              child: Obx(
                () => TextFormField(
                  cursorColor: Colors.white,
                  validator: (value) => Validators.combine([
                    () => Validators.isNotEmpty(value),
                    () => Validators.hasMinChars(value, 6)
                  ]),
                  controller: controller.password,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                  obscureText: controller.obscureText.value,
                  maxLength: 6,
                  decoration: InputDecoration(
                    counterText: '',
                    isDense: true,
                    border: InputBorder.none,
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    contentPadding: EdgeInsets.zero,
                    labelText: 'password'.tr,
                    labelStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    hintText: '',
                    suffixIcon: Obx(
                      () => IconButton(
                        onPressed: () => controller.toggleObscureText(),
                        icon: Icon(
                          controller.obscureText.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 30, 32, 50),
              child: Obx(() => AppButton(
                    isLoading: controller.isLoading.value,
                    onPressed: () => controller.authLogin(),
                    buttonType: AppButtonType.outlined,
                    labelText: 'access'.tr,
                    color: Colors.white,
                  )),
            ),
            const Spacer(),
            AppButton(
              onPressed: () async => Get.to(
                  () => const CodeValidatePage(
                        page: 0,
                      ),
                  transition: Transition.rightToLeft),
              buttonType: AppButtonType.filled,
              labelText: 'forgot_password'.tr,
              color: thirdColor,
            ),
          ],
        ),
      ),
    );
  }
}
