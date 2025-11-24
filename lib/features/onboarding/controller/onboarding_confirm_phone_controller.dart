import 'dart:async';

import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_exception.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_basic_register_response.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_register_phone_request.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_verify_phone_request.dart';
import 'package:app_flutter_miban4/features/onboarding/repository/onboarding_confirm_phone_repository.dart';
import 'package:app_flutter_miban4/features/onboarding/repository/onboarding_register_phone_repository.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_dialogs.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_toaster.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingConfirmPhoneController extends GetxController {
  var isLoading = false.obs;
  final RxInt id = 0.obs;
  final RxInt prefix = 0.obs;
  final RxInt phone = 0.obs;

  final RxInt countdown = 30.obs;
  final RxBool canResend = false.obs;

  final key = GlobalKey<FormState>();

  final tokenController = TextEditingController();

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      id.value = arguments['id'] ?? 0;
      prefix.value = int.parse(arguments['prefix'] ?? '0');
      phone.value = int.parse(arguments['phone'] ?? '0');
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void startCountdown() {
    canResend.value = false;
    countdown.value = 30;

    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        canResend.value = true;
        _timer?.cancel();
      }
    });
  }

  Future<void> resendToken() async {
    if (!canResend.value) return;

    final request = OnboardingRegisterPhone(
        id: id.value, prefix: prefix.value, phone: phone.value);

    await OnboardingRegisterPhoneRepository().registerPhone(request);

    startCountdown();
  }

  Future<OnboardingBasicRegisterResponse> confirmPhone() async {
    final request = OnboardingVerifyPhoneRequest(
        id: id.value,
        prefix: prefix.value,
        phone: phone.value,
        code: int.parse(tokenController.text));

    try {
      final response =
          await OnboardingConfirmPhoneRepository().confirmPhone(request);

      if (response.id != 0) {
        Get.toNamed(AppRoutes.onboardingRegisterPassword,
            arguments: {'id': id.value});
        return response;
      }

      return response;
    } on ServerException catch (e, s) {
      AppLogger.I().error('Confirm phone token', e, s);
      CustomDialogs.showInformationDialog(
          content: e.message,
          onCancel: () => Get.offAllNamed(AppRoutes.splash));
      rethrow;
    } on ApiException catch (e) {
      ShowToaster.toasterInfo(message: e.message);
      rethrow;
    } catch (e, s) {
      AppLogger.I().error('Confirm phone token', e, s);
      ShowToaster.toasterInfo(message: e.toString());
      rethrow;
    } finally {
      isLoading(false);
    }
  }
}
