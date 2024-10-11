import 'package:app_flutter_miban4/data/model/payment/payment_link_entity.dart';
import 'package:app_flutter_miban4/data/util/helpers/currencyFormatter.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/controllers/paymentValue/payment_value_controller.dart';
import 'package:app_flutter_miban4/ui/screens/home/home_view_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/paymentLink/paymentLink.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PaymentLinkValue extends StatefulWidget {
  const PaymentLinkValue({Key? key}) : super(key: key);

  @override
  State<PaymentLinkValue> createState() => _PaymentLinkValueState();
}

class _PaymentLinkValueState extends State<PaymentLinkValue> {
  final TextEditingController _textEditingController = TextEditingController();
  Color _textColor = Colors.white;
  bool _buttonEnabled = false;
  final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: '');
  final PaymentValueController _paymentValueController =
      Get.put(PaymentValueController());

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
        title: AppLocalizations.of(context)!.demand_demand,
        backPage: () =>
            Get.off(() => HomeViewPage(), transition: Transition.leftToRight),
      ),
      body: Container(
        color: primaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Text(
                  AppLocalizations.of(context)!.demand_value,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: TextField(
                    keyboardType: const TextInputType.numberWithOptions(),
                    onChanged: (value) {
                      setState(() {
                        double parsedValue = double.tryParse(
                                value.replaceAll(RegExp(r'[^\d]'), '')) ??
                            0;
                        _textColor =
                            parsedValue >= 1000 ? secondaryColor : Colors.white;
                        _buttonEnabled = parsedValue >= 1000;
                      });
                    },
                    cursorColor: Colors.white,
                    controller: _textEditingController,
                    style: TextStyle(
                        color: _buttonEnabled ? secondaryColor : Colors.grey,
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
                          borderSide: BorderSide(color: Colors.white),
                        )),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CurrencyFormatter(),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Text(
                AppLocalizations.of(context)!.demand_minimum,
                style: const TextStyle(color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.demand_fees,
                    style: const TextStyle(color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.info_outline_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(32),
                child: Obx(
                  () => _paymentValueController.isLoading.value == false
                      ? ElevatedButton(
                          onPressed: _buttonEnabled
                              ? () async {
                                  String formattedValue = _textEditingController
                                      .text
                                      .replaceAll('R\$', '')
                                      .replaceAll('.', '')
                                      .replaceAll(',', '');
                                  int amount = int.parse(
                                          formattedValue.replaceAll('.', ''));

                                  try {
                                    await _paymentValueController
                                        .createLink(amount.toString());
                                  } catch (error) {
                                    throw Exception(error);
                                  }
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                _buttonEnabled ? secondaryColor : Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: const BorderSide(
                                  color: Colors.white, width: 2),
                            ),
                            alignment: Alignment.center,
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.proceed,
                            style: const TextStyle(color: Colors.white),
                          ),
                        )
                      : const CircularProgressIndicator(
                          color: Colors.white,
                        ),
                ),
              ),
            ],
          ),
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
