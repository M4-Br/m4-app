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

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      id.value = arguments['id'] ?? 0;
    }
  }

  Future<OnboardingBasicRegisterResponse> registerPhone() async {
    isLoading(true);

    final cleanedPhone = phoneController.text.replaceAll(RegExp(r'[^0-9]'), '');

    final phonePrefix = cleanedPhone.substring(0, 3);
    final phone = cleanedPhone.substring(3);

    final request = OnboardingRegisterPhone(
        id: id.value, prefix: int.parse(phonePrefix), phone: int.parse(phone));

    try {
      final response =
          await OnboardingRegisterPhoneRepository().registerPhone(request);

      if (response.id != 0) {
        Get.toNamed(AppRoutes.onboardingPhoneConfirm,
            arguments: {'id': id.value, 'prefix': phonePrefix, 'phone': phone});
        return response;
      }
      return response;
    } on ApiException catch (e, s) {
      AppLogger.I().error('Onboarding register Phone', e, s);
      if (ApiException is ServerException) {
        CustomDialogs.showInformationDialog(
            content: e.message,
            onCancel: () => Get.offAllNamed(AppRoutes.splash));
      }

      ShowToaster.toasterInfo(message: e.message);

      rethrow;
    } catch (e, s) {
      AppLogger.I().error('Onboarding register Phone', e, s);
      ShowToaster.toasterInfo(message: e.toString());
      rethrow;
    } finally {
      isLoading(false);
    }
  }
}
