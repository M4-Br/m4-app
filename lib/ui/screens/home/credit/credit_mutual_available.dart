import 'package:app_flutter_miban4/data/api/credit/available_mutual.dart';
import 'package:app_flutter_miban4/data/util/helpers/currencyFormatter.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/home/credit/credit_mutual_detail.dart';
import 'package:app_flutter_miban4/ui/screens/home/credit/credit_screen.dart';
import 'package:app_flutter_miban4/ui/screens/home/notifications/notifications_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreditMutualAvailable extends StatefulWidget {
  final String id;
  int? page;

  CreditMutualAvailable({super.key, required this.id, this.page = 0});

  @override
  State<CreditMutualAvailable> createState() => _CreditMutualAvailableState();
}

class _CreditMutualAvailableState extends State<CreditMutualAvailable> {
  late Future<Map<String, dynamic>> _mutual;
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _installmentController = TextEditingController();
  Color _errorColorValue = Colors.black;
  Color _errorColorInstallment = Colors.black;

  @override
  void initState() {
    super.initState();
    _mutual = getMutual(widget.id);
    _mutual.then((value) {
      _installmentController.text = value['installment'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarDefault(
        title: AppLocalizations.of(context)!.credit_credit.toUpperCase(),
        backPage: () => widget.page == 0
            ? Get.off(() => const CreditScreen(),
                transition: Transition.leftToRight)
            : Get.off(() => const Notifications(),
                transition: Transition.leftToRight),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
          future: _mutual,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: secondaryColor,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              final mutualResponse = snapshot.data;

              if (mutualResponse?.containsKey('message') == true) {
                if (mutualResponse!['message'].toString().isNotEmpty) {
                  return Center(
                      child: Text(
                    mutualResponse['message'],
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                    textAlign: TextAlign.center,
                  ));
                }
              }
            }
            final mutualResponse = snapshot.data;
            final currencyFormat =
                NumberFormat.currency(locale: 'pt_BR', symbol: '');

            _installmentController.text = mutualResponse!['installment'].toString();

            return Container(
              color: primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      mutualResponse!['group_account_name'],
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.credit_contribution,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                        Text(
                          AppLocalizations.of(context)!.credit_max_loan,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                              children: [
                                const TextSpan(text: 'R\$'),
                                TextSpan(
                                    text: currencyFormat.format(
                                        mutualResponse['contributions'] / 100))
                              ]),
                        ),
                        Text.rich(
                          TextSpan(
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                              children: [
                                const TextSpan(text: 'R\$'),
                                TextSpan(
                                    text: currencyFormat.format(mutualResponse[
                                            'total_amount_available'] /
                                        100))
                              ]),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: TextField(
                                cursorColor: primaryColor,
                                controller: _valueController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  CurrencyFormatter(),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _errorColorValue = double.tryParse(
                                                value.replaceAll(
                                                    RegExp(r"[^0-9]"), ''))! >
                                            mutualResponse[
                                                'total_amount_available']
                                        ? Colors.red
                                        : Colors.black;
                                  });
                                },
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: secondaryColor),
                                  ),
                                  errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  focusedErrorBorder:
                                      const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                  labelText: AppLocalizations.of(context)!
                                      .credit_request_value,
                                  labelStyle: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                  hintText: '',
                                  errorText: _errorColorValue == Colors.red
                                      ? AppLocalizations.of(context)!
                                          .credit_request_over
                                      : null,
                                ),
                                style: TextStyle(
                                    color: _errorColorValue, fontSize: 18),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: TextField(
                                cursorColor: primaryColor,
                                controller: _installmentController,
                                readOnly: true,
                                keyboardType:
                                    const TextInputType.numberWithOptions(),
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: secondaryColor),
                                  ),
                                  errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  focusedErrorBorder:
                                      const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                  labelText: AppLocalizations.of(context)!
                                      .credit_installment,
                                  labelStyle: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                  hintText: '',
                                ),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: _errorColorInstallment),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 45,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Get.to(
                  () => CreditMutualDetails(
                      id: widget.id,
                      amount: int.parse(_valueController.text
                              .replaceAll(RegExp(r"[^0-9]"), ''))
                          .toString()),
                  transition: Transition.rightToLeft);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            child: Text(
              AppLocalizations.of(context)!.proceed,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
