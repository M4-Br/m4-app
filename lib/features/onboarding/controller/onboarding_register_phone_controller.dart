import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_exception.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_basic_register_response.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_register_phone_request.dart';
import 'package:app_flutter_miban4/features/onboarding/repository/onboarding_register_phone_repository.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_dialogs.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_toaster.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OnboardingRegisterPhoneController extends GetxController {
  var isLoading = false.obs;
  final RxInt id = 0.obs;

  final phoneController = TextEditingController();

  final key = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      id.value = arguments['id'] ?? 0;
    }
  }

  Future<OnboardingBasicRegisterResponse?> registerPhone() async {
    if (key.currentState?.validate() != true) {
      return null;
    }
    isLoading(true);

    final cleanedPhone = phoneController.text.replaceAll(RegExp(r'[^0-9]'), '');

    final phonePrefix = cleanedPhone.substring(0, 2);
    final phone = cleanedPhone.substring(2);

    final request = OnboardingRegisterPhone(
        id: id.value, prefix: phonePrefix, phone: phone);
    try {
      final response =
          await OnboardingRegisterPhoneRepository().registerPhone(request);

      if (response.id != 0) {
        Get.toNamed(AppRoutes.onboardingPhoneConfirm,
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
      isLoading(false);
    }
  }
}
