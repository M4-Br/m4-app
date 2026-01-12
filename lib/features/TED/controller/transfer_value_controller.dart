import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/dates.dart';
// Importe o seu controller de contatos e o model
import 'package:app_flutter_miban4/features/TED/controller/transfer_contacts_controller.dart';
import 'package:app_flutter_miban4/features/TED/model/transfer_contacts_model.dart';
import 'package:app_flutter_miban4/features/TED/model/transfer_p2p_send_request.dart';
import 'package:app_flutter_miban4/features/TED/model/transfer_user_response.dart';
import 'package:app_flutter_miban4/features/TED/repository/transfer_send_p2p_repository.dart';
import 'package:app_flutter_miban4/features/balance/controller/balance_rx.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class TransferValueController extends BaseController {
  final BalanceRx balanceRx;
  TransferValueController(this.balanceRx);

  late TransferUserResponse userDestiny;

  TransferContactsModel? currentContactModel;

  final amountController = TextEditingController();
  final passwordController = TextEditingController();

  final isPasswordObscure = true.obs;
  final isValidAmount = false.obs;
  final _secureStorage = const FlutterSecureStorage();

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;

    if (args != null) {
      _handleArguments(args);
    } else {
      _handleError();
    }

    amountController.addListener(_validateAmount);
  }

  void _handleArguments(dynamic args) {
    if (args is TransferUserResponse) {
      userDestiny = args;
      currentContactModel = TransferContactsModel(
        name: args.name,
        document: args.document,
        username: args.username,
      );
    } else if (args is TransferContactsModel) {
      currentContactModel = args;

      userDestiny = TransferUserResponse(
        name: args.name ?? '',
        document: args.document ?? '',
        username: args.username ?? '',
        id: 0,
        email: '',
        person: null,
      );
    } else {
      _handleError();
    }
  }

  void _handleError() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowToaster.toasterInfo(
          message: 'Dados do beneficiário inválidos', isError: true);
      Get.back();
    });
  }

  @override
  void onClose() {
    amountController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void _validateAmount() {
    final value = _parseAmount(amountController.text);
    isValidAmount.value = value > 0;
  }

  double _parseAmount(String text) {
    String clean = text
        .replaceAll('R\$', '')
        .replaceAll('.', '')
        .replaceAll(',', '')
        .trim();
    if (clean.isEmpty) return 0.0;
    return double.parse(clean) / 100;
  }

  double get formattedBalance {
    return balanceRx.balance.value?.balanceCents ?? 0.0;
  }

  bool get hasBalance {
    final amount = _parseAmount(amountController.text);
    final balance = balanceRx.balance.value?.balanceCents ?? 0.0;
    return balance >= amount;
  }

  void onNext() {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!isValidAmount.value) {
      ShowToaster.toasterInfo(message: 'Digite um valor válido');
      return;
    }

    if (!hasBalance) {
      ShowToaster.toasterInfo(message: 'Saldo insuficiente', isError: true);
      return;
    }

    _openConfirmationSheet();
  }

  void togglePassword() => isPasswordObscure.toggle();

  void _openConfirmationSheet() {
    passwordController.clear();
    isPasswordObscure.value = true;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2))),
              ),
              const SizedBox(height: 24),

              AppText.titleMedium(Get.context!, 'Revisar Transferência',
                  textAlign: TextAlign.center),
              const SizedBox(height: 24),

              // Resumo
              _buildSummaryRow('Para', userDestiny.name ?? ''),
              const Divider(),
              _buildSummaryRow('CPF/CNPJ', userDestiny.document ?? ''),
              const Divider(),
              _buildSummaryRow('Valor', amountController.text, isBold: true),
              const Divider(),
              _buildSummaryRow('Data', DateTime.now().toDDMMYYYY()),

              const SizedBox(height: 32),

              AppText.bodySmall(
                  Get.context!, 'Digite sua senha para confirmar'),
              const SizedBox(height: 8),
              Obx(() => TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    obscureText: isPasswordObscure.value,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: '******',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: togglePassword,
                        icon: Icon(
                            isPasswordObscure.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: secondaryColor),
                      ),
                    ),
                  )),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      labelText: 'CANCELAR',
                      buttonType: AppButtonType.filled,
                      color: Colors.grey,
                      onPressed: () async => Get.back(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppButton(
                      labelText: 'CONFIRMAR',
                      color: secondaryColor,
                      onPressed: () async => _verifyAndTransfer(),
                    ),
                  ),
                ],
              ),
              // Espaço teclado
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(Get.context!).viewInsets.bottom)),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  fontSize: 16)),
        ],
      ),
    );
  }

  Future<void> _verifyAndTransfer() async {
    final password = passwordController.text;
    if (password.isEmpty) return;

    final savedPassword = await _secureStorage.read(key: 'user_password');

    if (savedPassword != null && savedPassword == password) {
      Get.back();
      _processTransfer();
    } else {
      ShowToaster.toasterInfo(message: 'Senha incorreta', isError: true);
      passwordController.clear();
    }
  }

  Future<void> _processTransfer() async {
    await executeSafe(() async {
      String amount = amountController.text
          .replaceAll('R\$', '')
          .replaceAll('.', '')
          .replaceAll(',', '')
          .trim();

      final result = await TransferSendP2pRepository().send(
          TransferP2pSendRequest(
              amount: int.parse(amount),
              password: passwordController.text,
              username: userDestiny.username ?? '',
              document: userDestiny.document ?? ''));

      if (result.transactionId != null) {
        _saveContactIfNeeded();

        Get.toNamed(AppRoutes.transferVoucher, arguments: result);
      }

      ShowToaster.toasterInfo(message: 'Transferência realizada com sucesso!');
    });
  }

  void _saveContactIfNeeded() {
    try {
      if (currentContactModel == null) return;
      if (currentContactModel?.document == null ||
          currentContactModel!.document!.isEmpty) {
        return;
      }
      final contactsController = Get.find<TransferContactsController>();
      final alreadyExists = contactsController.contacts
          .any((contact) => contact.document == currentContactModel!.document);

      if (!alreadyExists) {
        contactsController.addContact(currentContactModel!);
      }
    } catch (e) {
      AppLogger.I().info(e.toString());
    }
  }
}
