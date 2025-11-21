import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_exception.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_one_request.dart';
import 'package:app_flutter_miban4/features/onboarding/repository/onboarding_one_repository.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_toaster.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OnboardingOneController extends GetxController {
  var isLoading = false.obs;
  final key = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final documentController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  Future<void> register() async {
    isLoading(true);
    final cleanedPhone = phoneController.text.replaceAll(RegExp(r'[^0-9]'), '');

    final phonePrefix = cleanedPhone.substring(0, 3);
    final phone = cleanedPhone.substring(3);

    try {
      await OnboardingOneRepository()
          .basicRegister(
            OnboardingOneRequest(
                name: nameController.text,
                email: emailController.text,
                document: documentController.text
                    .replaceAll('.', '')
                    .replaceAll('-', ''),
                phonePrefix: phonePrefix,
                phone: phone),
          )
          .then((value) => value.success == true
              ? Get.toNamed(AppRoutes.onboardingConfirmEmail, arguments: {
                  'id': value.data?.id,
                  'email': emailController.text
                })
              : null);
    } on ApiException catch (e) {
      ShowToaster.toasterInfo(message: e.message);
      rethrow;
    } catch (e, s) {
      AppLogger.I().error('Confirm email token', e, s);
      ShowToaster.toasterInfo(message: e.toString());
      rethrow;
    } finally {
      isLoading(false);
    }
  }
}
