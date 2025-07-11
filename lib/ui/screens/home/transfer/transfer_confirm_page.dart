import 'package:app_flutter_miban4/data/api/transfer/transfe_other_bank.dart';
import 'package:app_flutter_miban4/data/api/transfer/transferSend.dart';
import 'package:app_flutter_miban4/data/model/transaction/transaction.dart';
import 'package:app_flutter_miban4/data/model/userData/balance.dart';
import 'package:app_flutter_miban4/l10n/app_localizations.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_success_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_success_ted.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_value_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransferConfirmPage extends StatefulWidget {
  final Map<String, dynamic>? userTransfer;
  final int? transfer;
  final String? code;
  final String? bank;
  final int? type;
  final String? document;
  final int? from;
  final String? name;
  final String? agency;
  final String? accountType;
  final String? accountNumber;
  final String? accountDigit;
  final Balance? balance;
  final String? agencyDigit;

  const TransferConfirmPage({
    super.key,
    this.userTransfer,
    this.transfer,
    this.code,
    this.bank,
    this.type,
    this.document,
    this.from,
    this.name,
    this.agency,
    this.accountType,
    this.accountNumber,
    this.accountDigit,
    this.balance,
    this.agencyDigit,
  });

  @override
  State<TransferConfirmPage> createState() => _TransferConfirmPageState();
}

class _TransferConfirmPageState extends State<TransferConfirmPage> {
  final TextEditingController _controller = TextEditingController();
  var _obscureText = false.obs;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final formattedDate = DateFormat('dd/MM/yyyy').format(currentDate);

    String formatCPF(cpf) {
      return cpf.substring(0, 3) +
          '.' +
          cpf.substring(3, 6) +
          '.' +
          cpf.substring(6, 9) +
          '-' +
          cpf.substring(9);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarDefault(
        title: AppLocalizations.of(context)!.transfer,
        backPage: () => Get.off(
            () => TransferValuePage(
                  userTransfer: widget.userTransfer,
                  code: widget.code,
                  bank: widget.bank,
                  type: widget.type,
                  document: widget.document,
                  from: widget.from,
                  name: widget.name,
                  accountDigit: widget.accountDigit,
                  accountType: widget.accountType,
                  accountNumber: widget.accountNumber,
                  agency: widget.agency,
                  balance: widget.balance,
                  agencyDigit: widget.agencyDigit,
                ),
            transition: Transition.leftToRight),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              AppLocalizations.of(context)!.transfer_confirm,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'R\$ ',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              Text(
                NumberFormat.currency(locale: 'pt_BR', symbol: '')
                    .format(widget.transfer! / 100),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: secondaryColor),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.transfer_date,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  formattedDate,
                  style: const TextStyle(
                      color: secondaryColor,
                      decoration: TextDecoration.underline,
                      fontSize: 16),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.transfer_to_confirm,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  widget.userTransfer?['name'].toString() ?? widget.name!,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'CPF:',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  formatCPF(widget.document),
                  style: const TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.transfer_bank,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  widget.userTransfer?['person']['branch_name'].toString() ??
                      widget.bank!,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.transfer_account,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  widget.userTransfer?['person']['account_number'].toString() ??
                      widget.accountNumber!,
                  style: const TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.transfer_fees,
                  style: const TextStyle(fontSize: 16),
                ),
                const Text(
                  '0,00',
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  widget.type == 0
                      ? showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog.adaptive(
                              title: Text(AppLocalizations.of(context)!
                                  .password_insert),
                              content: Obx(
                                () => TextField(
                                  controller: _controller,
                                  keyboardType: TextInputType.number,
                                  maxLength: 6,
                                  obscureText: !_obscureText.value,
                                  decoration: InputDecoration(
                                    suffixIcon: Obx(
                                      () => IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _obscureText.value =
                                                !_obscureText.value;
                                          });
                                        },
                                        icon: Icon(
                                          _obscureText.value == true
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: secondaryColor,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              actions: <Widget>[
                                SizedBox(
                                  width: double.infinity,
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!.cancel,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 40,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            int amount = widget.transfer!;
                                            String password = _controller.text;
                                            String username = widget
                                                .userTransfer!['username']
                                                .toString();
                                            String document = widget
                                                .userTransfer!['document']
                                                .toString();
                                            transactionSend(
                                                    context,
                                                    amount,
                                                    password,
                                                    username,
                                                    document)
                                                .then((Transaction? result) {
                                              if (result!.success == true) {
                                                Get.off(
                                                    () => TransferSuccessPage(
                                                        transaction: result),
                                                    transition:
                                                        Transition.rightToLeft);
                                              }
                                            });
                                            return AlertDialog.adaptive(
                                              title: Text(
                                                  AppLocalizations.of(context)!
                                                      .wait),
                                              content: const SizedBox(
                                                height: 20,
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: secondaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context)!.confirm,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        )
                      : showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog.adaptive(
                              title: Text(AppLocalizations.of(context)!
                                  .password_insert),
                              content: Obx(
                                () => TextField(
                                  controller: _controller,
                                  keyboardType: TextInputType.number,
                                  maxLength: 6,
                                  obscureText: !_obscureText.value,
                                  decoration: InputDecoration(
                                    suffixIcon: Obx(
                                      () => IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _obscureText.value =
                                                !_obscureText.value;
                                          });
                                        },
                                        icon: Icon(
                                          _obscureText.value == true
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: secondaryColor,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              actions: <Widget>[
                                SizedBox(
                                  width: double.infinity,
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!.cancel,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 40,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            int amount = widget.transfer!;
                                            String password = _controller.text;
                                            transferOtherBank(
                                                    context: context,
                                                    amount: amount.toString(),
                                                    password: password,
                                                    document: widget.document
                                                        .toString(),
                                                    name:
                                                        widget.name.toString(),
                                                    bankCode:
                                                        widget.code.toString(),
                                                    agency: widget.agency
                                                        .toString(),
                                                    agencyDigit: widget
                                                        .agencyDigit
                                                        .toString(),
                                                    accountNumber: widget
                                                        .accountNumber
                                                        .toString(),
                                                    accountDigit: widget
                                                        .accountDigit
                                                        .toString(),
                                                    accountType: widget
                                                        .accountType
                                                        .toString())
                                                .then((result) {
                                              if (result['id']
                                                  .toString()
                                                  .isNotEmpty) {
                                                Get.off(
                                                    () => TransactionSuccessTed(
                                                          document: widget
                                                              .document
                                                              .toString(),
                                                      id: result['id'],
                                                      bank: widget.bank,
                                                      account: widget.accountNumber,
                                                      amount: amount,
                                                      name: widget.name,
                                                        ),
                                                    transition:
                                                        Transition.rightToLeft);
                                              }
                                            });
                                            return AlertDialog.adaptive(
                                              title: Text(
                                                  AppLocalizations.of(context)!
                                                      .wait),
                                              content: const SizedBox(
                                                height: 20,
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: secondaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context)!.confirm,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)!.confirm,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
