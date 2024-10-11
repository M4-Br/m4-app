import 'package:app_flutter_miban4/data/model/qrCode/internQRCode.dart';
import 'package:app_flutter_miban4/data/model/userData/balance.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/home/home_view_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/qrcodePayment/qrcodeConfirmPayment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QRCodeReaderScreen extends StatefulWidget {
  late InternQRCode? qrCode;
  late Balance? balance;

  QRCodeReaderScreen({super.key, this.balance, this.qrCode});

  @override
  _QRCodeReaderScreenState createState() => _QRCodeReaderScreenState();
}

class _QRCodeReaderScreenState extends State<QRCodeReaderScreen> {
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
    _textEditingController.text = '0,00';
    _textEditingController.selection = TextSelection.fromPosition(
      TextPosition(offset: _textEditingController.text.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarDefault(
        title: AppLocalizations.of(context)!.transfer,
        backPage: () =>
            Get.off(() => HomeViewPage(), transition: Transition.leftToRight),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
            ),
            const Text(
              'Qual valor deseja \n transferir?',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'R\$',
                    style: TextStyle(fontSize: 32),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CurrencyTextInputFormatter(locale: 'pt_BR'),
                    ],
                    style: TextStyle(fontSize: 32, color: _textColor),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 32),
                    ),
                    onChanged: (value) {
                      setState(() {
                        String cleanedValue =
                            value.replaceAll(',', '').replaceAll('.', '');
                        double parsedValue =
                            double.tryParse(cleanedValue) ?? 0.0;
                        if (parsedValue > 100.0) {
                          _textColor = secondaryColor;
                        } else {
                          _textColor = Colors.grey;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            Text(
                'Saldo disponível: R\$ ${currencyFormat.format(widget.balance!.balanceCents)}'),
            const Spacer(),
            const Text('Valor mínimo de transferência R\$ 10,00'),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () async {
                  String formattedValue = _textEditingController.text
                      .replaceAll(',', '')
                      .replaceAll('.', '');
                  int transferValue = int.tryParse(formattedValue) ?? 0;

                  Get.off(() => QRCodeConfirmPayment(transfer: transferValue, qrCode: widget.qrCode,), transition: Transition.rightToLeft);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _textColor == secondaryColor
                      ? secondaryColor
                      : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.white, width: 2),
                  ),
                  alignment: Alignment.center,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'CONTINUAR',
                  style: TextStyle(color: Colors.white),
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

  @override
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
