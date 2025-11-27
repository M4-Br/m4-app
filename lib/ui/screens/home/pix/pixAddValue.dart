import 'package:app_flutter_miban4/data/model/qrCode/decodeQRCode.dart';
import 'package:app_flutter_miban4/data/model/userData/balance.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/features/home/presentation/home_view_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixCodeDecode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class PixAddValue extends StatefulWidget {
  late Balance? balance;
  late DecodeQRCode? qrCode;

  PixAddValue({Key? key, this.balance, this.qrCode}) : super(key: key);

  @override
  State<PixAddValue> createState() => _PixAddValueState();
}

class _PixAddValueState extends State<PixAddValue> {
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
    double availableBalance =
        double.parse(widget.balance!.balance!.toString().replaceAll(',', '.'));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarDefault(
        title: 'PIX',
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
            Text(
              'transfer_value'.tr,
              style: const TextStyle(fontSize: 20, color: Colors.black),
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
              '${'balance_available'.tr} R\$ ${currencyFormat.format(availableBalance)}',
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            const Spacer(),
            Text(
              '${'transfer_minimum'.tr} R\$ 10,00',
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () async {
                  String formattedValue = _textEditingController.text
                      .replaceAll(',', '')
                      .replaceAll('.', '');
                  int transferValue = int.tryParse(formattedValue) ?? 0;

                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: PixCodeDecode(
                            balance: widget.balance,
                            qrCode: widget.qrCode,
                            page: 1,
                          ),
                          type: PageTransitionType.rightToLeft));
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
                child: Text(
                  'next'.tr,
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
