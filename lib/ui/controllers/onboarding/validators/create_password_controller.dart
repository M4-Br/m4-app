
import 'package:app_flutter_miban4/data/api/login/cnpj/register_password.dart';
import 'package:app_flutter_miban4/data/api/onboarding/step_seven.dart';
import 'package:app_flutter_miban4/ui/screens/login/login_page.dart';
import 'package:app_flutter_miban4/ui/screens/login/password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CreatePasswordController extends GetxController {
  var isLoading = false.obs;

  Future<void> createPassword(String password, String confirmPassword) async {
    isLoading(true);

    try {
      final Map<String, dynamic> response = await stepSeven(password, confirmPassword);

      if(response['status'] == 'approved') {
        Get.off(() => PasswordPage(document: response['document']), transition: Transition.rightToLeft);
      } else {
        throw Exception('Erro ao cadastrar senha: ${response['message']}');
      }
    } catch (error) {
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }

  Future<void> createCnpjPassword(String password, String newPassword, BuildContext context) async {
    isLoading(true);

    try {
      final Map<String, dynamic> response = await registerPassword(password, newPassword);

      if (response['id'].toString().isNotEmpty) {
        Get.snackbar('password_success'.tr, 'password_content'.tr,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 5),
            backgroundColor: Colors.white,
            icon: SvgPicture.asset('assets/images/miban4_colored_logo.svg'),
            padding: const EdgeInsets.all(8));
        Get.off(() => const LoginPage(), transition: Transition.rightToLeft);
      }
    } catch (error) {
      isLoading(false);
      throw Exception(error.toString());
    } finally {
      isLoading(false);
    }
  }
}