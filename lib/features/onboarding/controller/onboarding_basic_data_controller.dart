import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_exception.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_basic_register_request.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_basic_register_response.dart';
import 'package:app_flutter_miban4/features/onboarding/repository/onboarding_basic_register_repository.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_dialogs.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_toaster.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingBasicDataController extends GetxController {
  var isLoading = false.obs;
  final RxInt id = 0.obs;

  final key = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final promotionalCodeController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      id.value = arguments['id'] ?? 0;
    }
  }

  Future<OnboardingBasicRegisterResponse?> registerBasicData() async {
    if (key.currentState?.validate() != true) {
      return null;
    }

    isLoading(true);

    try {
      final request = OnboardingBasicRegisterRequest(
          id: id.value,
          fullName: fullNameController.text,
          username: usernameController.text,
          email: emailController.text,
          promotionalCode: promotionalCodeController.text.isEmpty
              ? ''
              : promotionalCodeController.text);

      final response =
          await OnboardingBasicRegisterRepository().basicRegister(request);

      if (response.id != 0) {
        Get.toNamed(AppRoutes.onboardingConfirmEmail, arguments: {
          'id': id.value,
          'email': emailController.text,
          'fullName': fullNameController.text,
          'username': usernameController.text,
        });
        return response;
      }

      return response;
    } catch (e, s) {
      AppLogger.I().error('Onboarding Basic Register', e, s);
      if (e is ApiException) {
        if (e.statusCode == 500) {
          CustomDialogs.showInformationDialog(
              content: 'Verifique sua conexão e tente novamente mais tarde.',
              onCancel: () => Get.offAllNamed(AppRoutes.splash));
        } else {
          ShowToaster.toasterInfo(
            message: e.message,
            isError: true,
          );
        }
      }
      return null;
    } finally {
      isLoading(false);
    }
  }
}
