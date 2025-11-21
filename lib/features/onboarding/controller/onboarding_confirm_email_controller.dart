import 'dart:async';

import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_exception.dart';
import 'package:app_flutter_miban4/features/geral/model/message_response.dart';
import 'package:app_flutter_miban4/features/onboarding/repository/onboarding_send_email_token_repository.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_dialogs.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_toaster.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OnboardingConfirmEmailController extends GetxController {
  var isLoading = false.obs;

  final RxInt id = 0.obs;
  final RxString email = ''.obs;

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
    }

    sendToken();
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

    await sendToken();
    startCountdown();
  }

  Future<void> sendToken() async {
    isLoading(true);
    try {
      await OnboardingSendEmailTokenRepository().sendEmailToken(id.value);
    } on ServerException catch (e) {
      CustomDialogs.showInformationDialog(
          content: e.message,
          onCancel: () => Get.offAllNamed(AppRoutes.splash));
    } on ApiException catch (e) {
      ShowToaster.toasterInfo(message: e.message);
    } catch (e, s) {
      AppLogger.I().error('Send email token', e, s);
      ShowToaster.toasterInfo(message: e.toString());
    } finally {
      isLoading(false);
    }
    return await OnboardingSendEmailTokenRepository().sendEmailToken(id.value);
  }

  Future<MessageResponse> validateEmail() async {
    isLoading(true);
    try {
      final value = await OnboardingSendEmailTokenRepository()
          .validateToken(tokenController.text.toString());

      if (value.success == true) {
        Get.toNamed(
          AppRoutes.onboardingRegisterPassword,
          arguments: {'id': id.value},
        );
      } else {
        ShowToaster.toasterInfo(message: 'Verifique o token e tente novamente');
      }
      return value;
    } on ServerException catch (e) {
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
