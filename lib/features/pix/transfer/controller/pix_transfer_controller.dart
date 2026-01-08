import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/balance/controller/balance_rx.dart';
import 'package:app_flutter_miban4/features/pix/pixWithKey/model/pix_validate_key_response.dart';
import 'package:app_flutter_miban4/features/pix/transfer/model/pix_transfer_request.dart';
import 'package:app_flutter_miban4/features/pix/transfer/model/pix_transfer_response.dart';
import 'package:app_flutter_miban4/features/pix/transfer/repository/pix_transfer_repository.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dialogs.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PixTransferController extends BaseController {
  final BalanceRx balanceRx;
  PixTransferController(this.balanceRx);

  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  final passwordController = TextEditingController();

  late PixValidateKeyResponse pixData;
  late String transferType;

  final selectedDate = DateTime.now().obs;
  final isPasswordObscure = true.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;

    if (args != null && args is Map) {
      if (args['key'] is PixValidateKeyResponse) {
        pixData = args['key'];
      } else {
        _handleError('Objeto Pix inválido no Map');
        return;
      }

      transferType = args['type']?.toString() ?? 'DEFAULT';

      if (args.containsKey('prefilledAmount') &&
          args['prefilledAmount'] != null) {
        _setPrefilledAmount(args['prefilledAmount'].toString());
      }
    } else if (args is PixValidateKeyResponse) {
      pixData = args;
      transferType = 'KEY';
    } else {
      _handleError('Argumentos inválidos ou nulos');
    }
  }

  void _setPrefilledAmount(String rawValue) {
    try {
      String cleanValue = rawValue.replaceAll(',', '.');
      cleanValue = cleanValue.replaceAll(RegExp(r'[^0-9.]'), '');

      double? value = double.tryParse(cleanValue);

      if (value != null) {
        final formatted =
            NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(value);
        amountController.text = formatted;
      }
    } catch (e, s) {
      AppLogger.I().error('Erro ao preencher valor automático', e, s);
    }
  }

  void _handleError(String msg) {
    ShowToaster.toasterInfo(message: 'Dados não encontrados');
    AppLogger.I()
        .error('Pix Transfer', '$msg: ${Get.arguments}', StackTrace.current);
    Get.back();
  }

  @override
  void onClose() {
    amountController.dispose();
    descriptionController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  String get formattedReceiverDoc {
    final doc = pixData.nationalRegistration;
    if (doc.length > 11) {
      return '${doc.substring(0, 2)}.${doc.substring(2, 5)}.${doc.substring(5, 8)}/${doc.substring(8, 12)}-${doc.substring(12)}';
    } else if (doc.length == 11) {
      return '${doc.substring(0, 3)}.${doc.substring(3, 6)}.${doc.substring(6, 9)}-${doc.substring(9)}';
    }
    return doc;
  }

  String get formattedReceiverName {
    return pixData.name.length > 18
        ? '${pixData.name.substring(0, 18)}...'
        : pixData.name;
  }

  String get formattedDate =>
      DateFormat('dd/MM/yyyy').format(selectedDate.value);

  void togglePasswordVisibility() => isPasswordObscure.toggle();

  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }

  void showConfirmationDialog() {
    if (amountController.text.isEmpty || amountController.text == 'R\$ 0,00') {
      ShowToaster.toasterInfo(message: 'Digite um valor para transferência');
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
                onPressed: togglePasswordVisibility,
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
        Get.back();
        _processTransfer();
      },
    );
  }

  Future<void> _processTransfer() async {
    if (passwordController.text.isEmpty) {
      ShowToaster.toasterInfo(
          message: 'Digite sua senha para confirmar a transferência.');
      return;
    }

    await executeSafe(() async {
      String rawAmount = amountController.text
          .replaceAll('R\$', '')
          .replaceAll('.', '')
          .replaceAll(',', '')
          .trim();

      final formattedDateApi =
          DateFormat('yyyy-MM-dd').format(selectedDate.value);

      final payeeData = PixTransferPayee(
        bankAccountNumber: pixData.bankAccountNumber,
        bankAccountType: pixData.bankAccountType,
        bankBranchNumber: pixData.bankBranchNumber,
        beneficiaryType: pixData.beneficiaryType,
        document: pixData.nationalRegistration,
        ispb: pixData.ispb,
        name: pixData.name,
        key: pixData.key,
      );

      final request = PixTransferRequest(
        amount: rawAmount,
        description: descriptionController.text,
        idEndToEnd: pixData.idEndToEnd,
        password: passwordController.text,
        idTx: '',
        transferType: 1,
        startDate: formattedDateApi,
        endDate: formattedDateApi,
        payee: payeeData,
      );

      final PixTransferResponse result =
          await PixTransferRepository().doTransfer(request: request);

      if (result.success == true) {
        ShowToaster.toasterInfo(
            message: 'Transferência realizada com sucesso!');
        Get.toNamed(AppRoutes.pixInvoice, arguments: {
          'result': result,
          'request': request,
        });
      } else {
        ShowToaster.toasterInfo(
            message: 'Erro ao realizar transferência.', isError: true);
      }
    });
  }
}
