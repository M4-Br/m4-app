import 'dart:async';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_exception.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_basic_register_request.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_basic_register_response.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_verify_email_request.dart';
import 'package:app_flutter_miban4/features/onboarding/repository/onboarding_basic_register_repository.dart';
import 'package:app_flutter_miban4/features/onboarding/repository/onboarding_verfy_email_token_repository.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_dialogs.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_toaster.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OnboardingConfirmEmailController extends GetxController {
  var isLoading = false.obs;

  final RxInt id = 0.obs;
  final RxString email = ''.obs;
  final RxString fullName = ''.obs;
  final RxString userName = ''.obs;

  final formKey = GlobalKey<FormState>();

  final tokenController = TextEditingController();

  final RxInt countdown = 30.obs;
  final RxBool canResend = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      id.value = arguments['id'] ?? 0;
      email.value = arguments['email'] ?? 'Nenhum email encontrado';
      fullName.value = arguments['fullName'] ?? 'Nenhum nome encontrado';
      userName.value =
          arguments['username'] ?? 'Nenhum nome de usuário encontrado';
    }
    startCountdown();
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

    final request = OnboardingBasicRegisterRequest(
        id: id.value,
        fullName: fullName.value,
        username: userName.value,
        email: email.value,
        promotionalCode: null);

    await OnboardingBasicRegisterRepository().basicRegister(request);
    startCountdown();
  }

  Future<OnboardingBasicRegisterResponse> validateEmail() async {
    isLoading(true);
    try {
      final request = OnboardingVerifyEmailRequest(
        id: id.value,
        fullName: fullName.value,
        username: userName.value,
        email: email.value,
        promotionalCode: null,
        code: int.parse(tokenController.text),
      );

      final response =
          OnboardingVerifyEmailTokenRepository().validateToken(request);
      Get.toNamed(AppRoutes.onboardingPhone, arguments: {'id': id.value});

      return response;
    } on ServerException catch (e, s) {
      AppLogger.I().error('Confirm email token', e, s);
      CustomDialogs.showInformationDialog(
          content: e.message,
          onCancel: () => Get.offAllNamed(AppRoutes.splash));
      rethrow;
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
