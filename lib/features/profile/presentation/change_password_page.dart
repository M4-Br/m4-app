import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/data/api/password/change_password.dart';
import 'package:app_flutter_miban4/features/profile/controller/change_password_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordPage extends GetView<ChangePasswordController> {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: Text(
          'change_app_password'.tr.toUpperCase(),
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.passwordController,
                keyboardType: const TextInputType.numberWithOptions(),
                obscureText: controller.passwordObscure.value,
                maxLength: 6,
                cursorColor: secondaryColor,
                validator: (value) {
                  if (value!.length < 6) {
                    return 'change_password_validate'.tr;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text('change_password_password'.tr),
                  labelStyle:
                      const TextStyle(color: Colors.black, fontSize: 15),
                  floatingLabelStyle:
                      const TextStyle(color: secondaryColor, fontSize: 15),
                  counterText: '',
                  suffixIcon: IconButton(
                    onPressed: () => controller.toggleObscure(),
                    icon: Icon(
                      controller.passwordObscure.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 36),
                child: TextFormField(
                  controller: controller.newPasswordController,
                  keyboardType: const TextInputType.numberWithOptions(),
                  obscureText: controller.passwordObscure.value,
                  maxLength: 6,
                  cursorColor: secondaryColor,
                  validator: (value) {
                    if (value!.length < 6) {
                      return 'change_password_validate'.tr;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text('change_password_new'.tr),
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 15),
                    floatingLabelStyle:
                        const TextStyle(color: secondaryColor, fontSize: 15),
                    counterText: '',
                    suffixIcon: IconButton(
                      onPressed: () => controller.toggleObscure(),
                      icon: Icon(
                        controller.passwordObscure.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              TextFormField(
                controller: controller.confirmNewPasswordController,
                keyboardType: const TextInputType.numberWithOptions(),
                obscureText: controller.passwordObscure.value,
                maxLength: 6,
                cursorColor: secondaryColor,
                validator: (value) {
                  if (value!.length < 6) {
                    return 'change_password_validate'.tr;
                  } else if (value != controller.newPasswordController.text) {
                    return 'change_password_not_equal'.tr;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text('change_password_new_confirm'.tr),
                  labelStyle:
                      const TextStyle(color: Colors.black, fontSize: 15),
                  floatingLabelStyle:
                      const TextStyle(color: secondaryColor, fontSize: 15),
                  counterText: '',
                  suffixIcon: IconButton(
                    onPressed: () => controller.toggleObscure(),
                    icon: Icon(
                      controller.passwordObscure.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: controller.isLoading.value == false
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () => _changePassword(
                      controller.passwordController.text,
                      controller.newPasswordController.text),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    'confirm'.tr.toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          : const Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: CircularProgressIndicator(
                  color: secondaryColor,
                ),
              ),
            ),
    );
  }

  _changePassword(String password, String confirm) async {
    if (controller.formKey.currentState!.validate()) {
      try {
        controller.isLoading(true);
        await changePassword(password, confirm).then((value) {
          if (value['success'] == true) {
            Get.snackbar('message'.tr, 'change_password_changed'.tr);

            Get.back();
          }
        });
      } catch (e) {
        throw Exception(e.toString());
      } finally {
        controller.isLoading(false);
      }
    } else {
      return;
    }
  }
}
