import 'package:app_flutter_miban4/data/api/account/get_financial_cap.dart';
import 'package:app_flutter_miban4/data/api/credit/credit_request.dart';
import 'package:app_flutter_miban4/data/api/credit/credit_simulate.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/home/credit/credit_mutual_available.dart';
import 'package:app_flutter_miban4/ui/screens/home/credit/credit_request.dart';
import 'package:app_flutter_miban4/ui/screens/home/credit/terms_credit.dart';
import 'package:app_flutter_miban4/ui/screens/home/perfil/financial_data_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreditMutualDetails extends StatefulWidget {
  final String id;
  final String amount;
  final bool? pageRead;

  const CreditMutualDetails(
      {super.key, required this.id, required this.amount, this.pageRead = false});

  @override
  State<CreditMutualDetails> createState() => _CreditMutualDetailsState();
}

class _CreditMutualDetailsState extends State<CreditMutualDetails> {
  late Future<Map<String, dynamic>> _creditSimulated;
  bool check = false;
  var isLoading = false.obs;

  void _navigateToTerms() {
    Get.to(
        () => CreditTerms(
              id: widget.id,
              amount: widget.amount,
            ),
        transition: Transition.rightToLeft);
  }

  @override
  void initState() {
    super.initState();
    _creditSimulated = simulateCredit(widget.id, widget.amount);
    check = widget.pageRead ?? false;
  }

  @override
  void dispose() {
    super.dispose();
    setState(() {
      check == false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(
        title: 'credit_request'.toUpperCase().tr,
        backPage: () => Get.off(() => CreditMutualAvailable(id: widget.id),
            transition: Transition.leftToRight),
      ),
      backgroundColor: primaryColor,
      body: FutureBuilder<Map<String, dynamic>>(
          future: _creditSimulated,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                color: Colors.white,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: secondaryColor,
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              final simulatedResponse = snapshot.data!;
              final currencyFormat =
                  NumberFormat.currency(locale: 'pt_BR', symbol: '');

              return Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        color: Color(0xFF02010f)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Text(
                          'credit_simulation'.tr,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(
                              'credit_you_receive'.tr,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Center(
                            child: Text.rich(
                              TextSpan(
                                  style: const TextStyle(
                                      fontSize: 42,
                                      fontWeight: FontWeight.bold,
                                      color: secondaryColor),
                                  children: [
                                    const TextSpan(text: 'R\$'),
                                    TextSpan(
                                      text: currencyFormat.format(
                                          int.parse(widget.amount) / 100),
                                    ),
                                  ]),
                            ),
                          ),
                          Center(
                            child: Text.rich(TextSpan(
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 18),
                                children: [
                                  TextSpan(
                                      text: 'credit_paid'.tr),
                                  TextSpan(
                                      text:
                                          ' ${simulatedResponse['installment']} x ${'off'.tr} R\$${currencyFormat.format(simulatedResponse['installment_amount'] / 100)}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold))
                                ])),
                          ),
                          Container(
                            color: grey100,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'credit_group'.tr,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          '${simulatedResponse['group_name']}',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                         'credit_pay_total'.tr,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                        Text.rich(
                                          TextSpan(
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                              children: [
                                                const TextSpan(text: 'R\$'),
                                                TextSpan(
                                                    text: currencyFormat.format(
                                                        simulatedResponse[
                                                                'total_amount'] /
                                                            100))
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'credit_fee_value'.tr,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                        Text.rich(
                                          TextSpan(
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                              children: [
                                                const TextSpan(text: 'R\$'),
                                                TextSpan(
                                                    text: currencyFormat.format(
                                                        simulatedResponse[
                                                                'fee_value'] /
                                                            100))
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'credit_fees'.tr,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                        Text.rich(
                                          TextSpan(
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                              children: [
                                                TextSpan(
                                                    text:
                                                        '${currencyFormat.format(simulatedResponse['fee'] / 100)} % '),
                                                TextSpan(
                                                    text: 'credit_monthly'.tr)
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'credit_services'.tr,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                      Text.rich(
                                        TextSpan(
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                            children: [
                                              const TextSpan(text: 'R\$'),
                                              TextSpan(
                                                  text: currencyFormat.format(
                                                      simulatedResponse[
                                                              'interests'] /
                                                          100))
                                            ]),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black54,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                    activeColor: secondaryColor,
                                    value: check,
                                    onChanged: (newValue) {
                                      if (widget.pageRead == false) {
                                        Get.to(
                                            () => CreditTerms(
                                                  id: widget.id,
                                                  amount: widget.amount,
                                                ),
                                            transition: Transition.rightToLeft);
                                      } else {
                                        setState(() {
                                          check = newValue!;
                                        });
                                      }
                                    },
                                  ),
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () {
                                        _navigateToTerms();
                                      },
                                      child: Text(
                                        'terms_read'.tr,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black87,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: SizedBox(
                              height: 45,
                              width: double.infinity,
                              child: Obx(() => isLoading.value == false
                                  ? ElevatedButton(
                                      onPressed: check == true
                                          ? _verifyFinancial
                                          : null,
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: check
                                              ? secondaryColor
                                              : Colors.grey,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50))),
                                      child: Text(
                                        'credit_request'
                                            .toUpperCase().tr,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ))
                                  : const Center(
                                      child: CircularProgressIndicator(
                                        color: secondaryColor,
                                      ),
                                    )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }

  Future<void> _request() async {
    try {
      isLoading(true);
      await requestCredit(widget.id.toString(), widget.amount.toString())
          .then((value) {
        if (value == true) {
          Get.to(() => const CreditRequest(),
              transition: Transition.rightToLeft);
        }
      });
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> _verifyFinancial() async {
    try {
      isLoading(true);
      await getFinancialCap().then((result) {
        if (result['update_register'] == true) {
          isLoading(false);
          Get.to(
              () => FinancialDataPage(
                    groupID: widget.id,
                  ),
              transition: Transition.rightToLeft);
        } else {
          _request();
        }
      });
    } catch (e) {
      isLoading(false);
      throw Exception(e.toString());
    }
  }
}
