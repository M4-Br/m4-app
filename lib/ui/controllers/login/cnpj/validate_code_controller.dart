import 'package:app_flutter_miban4/data/api/login/cnpj/send_code.dart';
import 'package:app_flutter_miban4/data/api/login/cnpj/validate_code.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_password_register_page.dart';
import 'package:get/get.dart';

class ValidateCodeController extends GetxController {
  var isLoading = false.obs;
  var isLoadingPassword = false.obs;

  Future<void> sendCode(int page) async {
    try {
      isLoading(true);
      await sendCnpjCode();
    } catch (error) {
      isLoading(false);
      throw Exception(error.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> validateCode(String code, int page) async {
    isLoadingPassword(true);

    final bool response = await validateCnpjCode(code);

    try {
      if (response == true) {
        isLoadingPassword(false);
        Get.off(() => OnboardingPasswordRegisterPage(page: page,), transition: Transition.rightToLeft);
      }
    } catch (error) {
      isLoadingPassword(false);
      throw Exception(error);
    } finally {
      isLoadingPassword(false);
    }
  }
}
