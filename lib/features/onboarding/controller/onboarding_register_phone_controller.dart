import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_exception.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_basic_register_response.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_register_phone_request.dart';
import 'package:app_flutter_miban4/features/onboarding/repository/onboarding_register_phone_repository.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dialogs.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OnboardingRegisterPhoneController extends GetxController {
  final key = GlobalKey<FormState>();
  final phoneController = TextEditingController();

  final isLoading = false.obs;
  final enable = false.obs;
  final RxInt id = 0.obs;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      id.value = arguments['id'] ?? 0;
    }
    phoneController.addListener(_checkValidation);
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }

  void _checkValidation() {
    final cleanPhone = phoneController.text.replaceAll(RegExp(r'[^0-9]'), '');
    enable.value = cleanPhone.length >= 11;
  }

  Future<OnboardingBasicRegisterResponse?> registerPhone() async {
    if (!enable.value) return null;

    if (key.currentState?.validate() != true) {
      return null;
    }

    isLoading.value = true;

    final cleanedPhone = phoneController.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (cleanedPhone.length < 11) {
      isLoading.value = false;
      return null;
    }

    final phonePrefix = cleanedPhone.substring(0, 2);
    final phone = cleanedPhone.substring(2);

    final request = OnboardingRegisterPhone(
        id: id.value, prefix: phonePrefix, phone: phone);

    try {
      final response =
          await OnboardingRegisterPhoneRepository().registerPhone(request);

      if (response.id != 0) {
        Get.toNamed(AppRoutes.onboardingConfirmPhone,
            arguments: {'id': id.value, 'prefix': phonePrefix, 'phone': phone});
        return response;
      }
      return response;
    } catch (e, s) {
      AppLogger.I().error('Onboarding register Phone', e, s);
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
      isLoading.value = false;
    }
  }
}
