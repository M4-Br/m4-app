import 'package:app_flutter_miban4/data/model/userData/balance.dart';
import 'package:app_flutter_miban4/data/util/helpers/currencyFormatter.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_confirm_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_contact_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_add_person_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TransferValuePage extends StatefulWidget {
  final Balance? balance;
  final Map<String, dynamic>? userTransfer;
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
  final String? agencyDigit;

  const TransferValuePage(
      {super.key,
      this.balance,
      this.userTransfer,
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
      this.agencyDigit});

  @override
  State<TransferValuePage> createState() => _TransferValuePageState();
}

class _TransferValuePageState extends State<TransferValuePage> {
  final TextEditingController _textEditingController = TextEditingController();
  Color _textColor = Colors.black;
  final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: '');

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarDefault(
        title: AppLocalizations.of(context)!.transfer,
        backPage: () => Get.off(
            () => widget.from == 0
                ? const TransferContactPage()
                : TransferAddPersonScreen(
                    userTransfer: widget.userTransfer,
                    code: widget.code.toString(),
                    bank: widget.bank.toString(),
                    type: widget.type!,
                    document: widget.document.toString(),
                  ),
            transition: Transition.leftToRight),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
            ),
            Text(
              AppLocalizations.of(context)!.transfer_value,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 36),
              child: TextField(
                onChanged: (_) {
                  setState(() {
                    _textEditingController.text.length > 7
                        ? _textColor = secondaryColor
                        : _textColor = Colors.grey;
                  });
                },
                controller: _textEditingController,
                style: TextStyle(
                    color: _textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  prefixStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  hintText: 'R\$ 0,00',
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                  contentPadding: EdgeInsets.only(bottom: 8.0),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyFormatter(),
                ],
              ),
            ),
            Text(
                '${AppLocalizations.of(context)!.transfer_balance} R\$ ${currencyFormat.format(double.parse(widget.balance!.balanceCents) / 100)}'),
            const Spacer(),
            Text('${AppLocalizations.of(context)!.transfer_minimum} R\$ 10,00'),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () async {
                  String formattedValue = _textEditingController.text
                      .replaceAll(',', '')
                      .replaceAll('.', '')
                      .replaceAll('R\$', '');
                  int transferValue = int.tryParse(formattedValue) ?? 0;
                  Get.to(
                      () => TransferConfirmPage(
                            userTransfer: widget.userTransfer,
                            transfer: transferValue,
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
                            agencyDigit: widget.accountDigit,
                          ),
                      transition: Transition.rightToLeft);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _textColor == secondaryColor
                      ? secondaryColor
                      : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  alignment: Alignment.center,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(
                  AppLocalizations.of(context)!.next,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CurrencyTextInputFormatter extends TextInputFormatter {
  final String locale;

  CurrencyTextInputFormatter({this.locale = 'en_US'});

  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = NumberFormat.currency(locale: locale, symbol: '')
        .format(double.parse(newValue.text) / 100);
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
