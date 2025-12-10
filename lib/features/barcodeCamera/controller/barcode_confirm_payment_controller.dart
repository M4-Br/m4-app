import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/dates.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/strings.dart';
import 'package:app_flutter_miban4/features/balance/controller/balance_rx.dart';
import 'package:app_flutter_miban4/features/barcodeCamera/model/barcode_payment_request.dart';
import 'package:app_flutter_miban4/features/barcodeCamera/model/barcode_response.dart';
import 'package:app_flutter_miban4/features/barcodeCamera/repository/barcode_repository.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dialogs.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class BarcodeConfirmPaymentController extends BaseController {
  final BalanceRx balanceRx;
  BarcodeConfirmPaymentController(this.balanceRx);

  late BarcodeResponse paymentData;

  final passwordController = TextEditingController();
  final isPasswordObscure = true.obs;
  final _secureStorage = const FlutterSecureStorage();

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;

    if (args != null && args is BarcodeResponse) {
      paymentData = args;
    } else {
      _handleError();
    }
  }

  void backToReader() {
    Get.until((route) => route.settings.name == AppRoutes.barcode);
  }

  void _handleError() {
    AppLogger.I().error('Barcode Payment', 'Invalid Args: ${Get.arguments}',
        StackTrace.current);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowToaster.toasterInfo(
          message: 'Dados do pagamento inválidos', isError: true);
      Get.back();
    });
  }

  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }

  double get _amountValue {
    return paymentData.amount;
  }

  double get _currentBalance => balanceRx.balance.value?.balanceCents ?? 0.0;

  String get formattedBalance => _currentBalance.toBRL();

  bool get hasSufficientBalance => _currentBalance >= _amountValue;

  String get todayFormatted => DateTime.now().toDDMMYYYY();

  void togglePassword() => isPasswordObscure.toggle();

  void openPasswordDialog() {
    if (!hasSufficientBalance) {
      ShowToaster.toasterInfo(
          message: 'Saldo insuficiente para realizar o pagamento.',
          isError: true);
      return;
    }

    passwordController.clear();
    isPasswordObscure.value = true;

    CustomDialogs.showWidgetDialog(
      title: 'password_insert'.tr,
      content: Obx(() => TextField(
            controller: passwordController,
            keyboardType: TextInputType.number,
            maxLength: 6,
            obscureText: isPasswordObscure.value,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              counterText: '',
              suffixIcon: IconButton(
                onPressed: togglePassword,
                icon: Icon(
                  isPasswordObscure.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: secondaryColor,
                ),
              ),
            ),
          )),
      onConfirm: _verifyAndProcess,
    );
  }

  Future<void> _verifyAndProcess() async {
    final typedPassword = passwordController.text;
    if (typedPassword.isEmpty) {
      ShowToaster.toasterInfo(message: 'Digite a senha', isError: true);
      return;
    }

    final String? savedPassword =
        await _secureStorage.read(key: 'user_password');

    if (savedPassword != null && savedPassword == typedPassword) {
      Get.back();
      FocusManager.instance.primaryFocus?.unfocus();
      _processPayment();
    } else {
      ShowToaster.toasterInfo(message: 'Senha incorreta!', isError: true);
      passwordController.clear();
    }
  }

  Future<void> _processPayment() async {
    await executeSafe(() async {
      final result = await BarcodeRepository().doPayment(
        BarcodePaymentRequest(
            amount: paymentData.amount.toInt(),
            password: passwordController.text,
            barcode: paymentData.barCode,
            date: paymentData.dueDate,
            assignor: paymentData.assignor),
      );

      if (result.success == true) {
        Get.toNamed(AppRoutes.barcodeVoucher, arguments: result);
      }
    });
  }
}
