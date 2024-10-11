import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/controllers/pix/my_limits_controller.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PixMyLimits extends StatefulWidget {
  const PixMyLimits({Key? key}) : super(key: key);

  @override
  State<PixMyLimits> createState() => _PixMyLimitsState();
}

class _PixMyLimitsState extends State<PixMyLimits> {
  NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  final MyLimitsController _limitsController = Get.put(MyLimitsController());

  @override
  void initState() {
    super.initState();
    _limitsController.myLimits();
  }

  @override
  Widget build(BuildContext context) {
    var format = NumberFormat.currency(locale: 'pt_BR', symbol: '');

    return Scaffold(
      appBar: AppBarDefault(
        title: AppLocalizations.of(context)!.pix_myLimits,
        backPage: () =>
            Get.off(() => PixHome(), transition: Transition.leftToRight),
      ),
      body: Obx(() => _limitsController.isLoading.value == true
          ? const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      AppLocalizations.of(context)!.pix_limits_p2p,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    color: grey120,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              "R\$ ${format.format(int.parse(_limitsController.pixLimits.value!.data[0].accountLimit) / 100)}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      AppLocalizations.of(context)!.pix_limits_p2b,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    color: grey120,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              "R\$ ${format.format(int.parse(_limitsController.pixLimits.value!.data[1].accountLimit) / 100)}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      AppLocalizations.of(context)!.pix_limits_same_person,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Card(
                    elevation: 2,
                    color: grey120,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              "R\$ ${format.format(int.parse(_limitsController.pixLimits.value!.data[2].accountLimit) / 100)}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
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
