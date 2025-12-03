import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/numbers.dart';
import 'package:app_flutter_miban4/features/balance/controller/balance_rx.dart';
import 'package:app_flutter_miban4/features/pix/copyPaste/model/pix_copy_paste_response.dart';
import 'package:app_flutter_miban4/features/pix/transfer/model/pix_transfer_request.dart';
import 'package:app_flutter_miban4/features/pix/transfer/model/pix_transfer_response.dart';
import 'package:app_flutter_miban4/features/pix/transfer/repository/pix_transfer_repository.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_dialogs.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PixCodeDecodeController extends BaseController {
  final BalanceRx balanceRx;
  PixCodeDecodeController(this.balanceRx);

  final passwordController = TextEditingController();
  final isPasswordObscure = true.obs;

  final _secureStorage = const FlutterSecureStorage();

  late PixDecodeResponse qrData;
  int originPage = 0;

  final _currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: '');

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;

    if (args != null && args is Map) {
      if (args['qrCode'] is PixDecodeResponse) {
        qrData = args['qrCode'];
        originPage = args['page'] ?? 0;
      } else {
        _handleError('Tipo de QR Code inválido');
      }
    } else {
      _handleError('Argumentos nulos ou inválidos');
    }
  }

  void _handleError(String msg) {
    AppLogger.I()
        .error('Pix Decode', '$msg: ${Get.arguments}', StackTrace.current);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowToaster.toasterInfo(
          message: 'Dados do QR Code inválidos', isError: true);
      Get.back();
    });
  }

  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }

  String get payerDocumentFormatted {
    String doc = qrData.payer.document;
    if (doc.length == 11) {
      return '${doc.substring(0, 3)}.${doc.substring(3, 6)}.${doc.substring(6, 9)}-${doc.substring(9)}';
    }
    return doc;
  }

  String get payerDocumentMasked {
    String doc = formatCPF(qrData.payer.document);
    if (doc.length > 10) {
      return '***${doc.substring(3, 11)}**';
    }
    return doc;
  }

  String formatCPF(String cpf) {
    if (cpf.length < 11) return cpf;
    return '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-${cpf.substring(9)}';
  }

  double get _currentBalance => balanceRx.balance.value?.balanceCents ?? 0.0;

  double get _transactionAmount => qrData.finalAmount;

  bool get hasSufficientBalance => _currentBalance >= _transactionAmount;

  String get amountFormatted => _currencyFormat.format(qrData.finalAmount);

  String get balanceText {
    return 'R\$ ${_currencyFormat.format(_currentBalance)}';
  }

  String get dueDateFormatted {
    if (qrData.dueDate == null) return '--/--/----';
    return DateFormat('dd/MM/yyyy').format(qrData.dueDate!);
  }

  void handleBack() {
    if (originPage == 1) {
      Get.offNamed(AppRoutes.pixAddValue);
    } else {
      Get.offNamed(AppRoutes.homeView);
    }
  }

  void togglePassword() => isPasswordObscure.toggle();

  void openPasswordDialog() {
    if (!hasSufficientBalance) {
      ShowToaster.toasterInfo(message: 'Saldo insuficiente', isError: true);
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
      onConfirm: () {
        _verifyAndProcess();
      },
    );
  }

  Future<void> _verifyAndProcess() async {
    final typedPassword = passwordController.text;

    if (typedPassword.isEmpty) {
      ShowToaster.toasterInfo(message: 'Digite a senha.', isError: true);
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
      final payeeData = PixTransferPayee(
        bankAccountNumber: qrData.payee.bankAccountNumber,
        bankAccountType: qrData.payee.bankAccountType,
        bankBranchNumber: qrData.payee.bankBranchNumber,
        beneficiaryType: qrData.payee.beneficiaryType,
        document: qrData.payee.document,
        ispb: qrData.payee.ispb,
        name: qrData.payee.name,
        key: qrData.payee.key,
      );

      final request = PixTransferRequest(
        amount: qrData.finalAmount.toCentsString(),
        description: qrData.description,
        idEndToEnd: qrData.idEndToEnd,
        password: passwordController.text,
        idTx: qrData.idTx,
        transferType: qrData.codeType,
        startDate: DateTime.now().toString(),
        endDate: DateTime.now().toString(),
        payee: payeeData,
      );

      final PixTransferResponse result =
          await PixTransferRepository().doTransfer(request: request);

      if (result.success == true) {
        Get.offNamed(AppRoutes.pixInvoice, arguments: result);
      }

      ShowToaster.toasterInfo(message: 'Pagamento realizado com sucesso!');
    });
  }
}
