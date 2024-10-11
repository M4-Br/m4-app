import 'package:app_flutter_miban4/data/api/account/get_financial_cap.dart';
import 'package:app_flutter_miban4/data/api/account/get_financial_params.dart';
import 'package:app_flutter_miban4/data/util/helpers/currencyFormatter.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/controllers/account/financial_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FinancialDataPage extends StatefulWidget {
  final String? groupID;

  const FinancialDataPage({super.key, this.groupID});

  @override
  State<FinancialDataPage> createState() => _FinancialDataPageState();
}

class _FinancialDataPageState extends State<FinancialDataPage> {
  late Future<Map<String, dynamic>> financialCap;
  late Future<Map<String, dynamic>> financialParams;
  String familySize = '';
  late String code;

  List<DropdownMenuItem<String>>? dropdownHouse;
  List<DropdownMenuItem<String>>? dropdownTransport;

  String? selectedHomeType;
  String? selectedTransport;

  double income = 0.0;
  String familySizeValue = '';
  String houseCostsValue = '';
  String transportCostsValue = '';
  String utilityCostsValue = '';
  String otherCostsValue = '';

  final TextEditingController _income = TextEditingController();
  final TextEditingController _familySize = TextEditingController();
  final TextEditingController _houseCosts = TextEditingController();
  final TextEditingController _transportCosts = TextEditingController();
  final TextEditingController _utilityCosts = TextEditingController();
  final TextEditingController _otherCosts = TextEditingController();
  final FinancialDataController _financialDataController =
      Get.put(FinancialDataController());
  final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  bool _isButtonEnabled = false;

  void _checkIfAllFieldsAreFilled() {
    bool allFieldsFilled = _income.text.isNotEmpty &&
        _familySize.text.isNotEmpty &&
        _houseCosts.text.isNotEmpty &&
        _transportCosts.text.isNotEmpty &&
        _utilityCosts.text.isNotEmpty &&
        _otherCosts.text.isNotEmpty;

    if (_isButtonEnabled != allFieldsFilled) {
      setState(() {
        _isButtonEnabled = allFieldsFilled;
      });
    }
  }


  @override
  void initState() {
    super.initState();
    _getParams();
    _getFinancial();
    _getFamilySize();
    _income.addListener(_checkIfAllFieldsAreFilled);
    _familySize.addListener(_checkIfAllFieldsAreFilled);
    _houseCosts.addListener(_checkIfAllFieldsAreFilled);
    _transportCosts.addListener(_checkIfAllFieldsAreFilled);
    _utilityCosts.addListener(_checkIfAllFieldsAreFilled);
    _otherCosts.addListener(_checkIfAllFieldsAreFilled);
  }

  @override
  void dispose() {
    super.dispose();
    _income.removeListener(_checkIfAllFieldsAreFilled);
    _familySize.removeListener(_checkIfAllFieldsAreFilled);
    _houseCosts.removeListener(_checkIfAllFieldsAreFilled);
    _transportCosts.removeListener(_checkIfAllFieldsAreFilled);
    _utilityCosts.removeListener(_checkIfAllFieldsAreFilled);
    _otherCosts.removeListener(_checkIfAllFieldsAreFilled);
  }

  void _getFinancial() async {
    financialCap = getFinancialCap();
  }

  void _getParams() async {
    financialParams = getFinancialParams();
    financialParams.then((params) {
      if (params.containsKey('customer_home')) {
        final customerHomeOptions = params['customer_home'] as List<dynamic>;
        dropdownHouse = customerHomeOptions.map((option) {
          return DropdownMenuItem<String>(
            value: option['value'] as String,
            child: Text(option['label'] as String),
          );
        }).toList();
      }
      setState(() {});
    });

    financialParams.then((params) {
      if (params.containsKey('customer_transport')) {
        final customerTransportOptions =
            params['customer_transport'] as List<dynamic>;
        dropdownTransport = customerTransportOptions.map((option) {
          return DropdownMenuItem<String>(
            value: option['value'] as String,
            child: Text(option['label'] as String),
          );
        }).toList();
      }
      setState(() {});
    });
  }

  void _getFamilySize() async {
    familySizeValue =
        await SharedPreferencesFunctions.getString(key: 'familySize');

    setState(() {
      _familySize.text = familySizeValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarDefault(
        title: AppLocalizations.of(context)!.account_data,
        backPage: () => Get.back(),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
          future: financialCap,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: secondaryColor,
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Center(
                  child: Text('Error: ${snapshot.error}'),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.toString().isEmpty) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: const Center(
                  child: Text('Erro ao exibir dados'),
                ),
              );
            } else {
              final data = snapshot.data!;
              final incomeFamily = data['income_family'];
              final houseCosts = data['house_cost'];
              final transportCosts = data['transport_cost'];
              final utilityCosts = data['utilities_cost'];
              final otherCosts = data['other_cost'];
              final house = data['house'];
              final transport = data['transport'];

              _income.text = formatter.format(incomeFamily / 100);
              _houseCosts.text = formatter.format(houseCosts / 100);
              _transportCosts.text = formatter.format(transportCosts / 100);
              _utilityCosts.text = formatter.format(utilityCosts / 100);
              _otherCosts.text = formatter.format(otherCosts / 100);

              WidgetsBinding.instance.addPostFrameCallback((_) {
                _checkIfAllFieldsAreFilled();
              });

              return Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          AppLocalizations.of(context)!
                              .financial_info
                              .toUpperCase(),
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .financial_inf_att
                                .toUpperCase(),
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                          Text(
                            data['update_date'] != null
                                ? DateFormat('dd/MM/yyyy')
                                    .format(DateTime.parse(data['update_date']))
                                : '',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .financial_house
                                .toUpperCase(),
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DropdownButton<String>(
                                value: selectedHomeType,
                                items: dropdownHouse,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedHomeType = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .financial_transport
                                .toUpperCase(),
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DropdownButton<String>(
                                value: selectedTransport,
                                items: dropdownTransport,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedTransport = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .financial_income
                                .toUpperCase(),
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                          Expanded(
                            child: TextFormField(
                              textAlign: TextAlign.right,
                              controller: _income,
                              readOnly: false,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CurrencyFormatter(),
                              ],
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: formatter.format(
                                    int.parse(incomeFamily.toString()) / 100),
                                hintStyle: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .financial_family
                                .toUpperCase(),
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                          ),
                          Expanded(
                            child: TextFormField(
                              textAlign: TextAlign.right,
                              controller: _familySize,
                              readOnly: false,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              decoration: const InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black54),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: secondaryColor),
                                ),
                                contentPadding: EdgeInsets.zero,
                                labelStyle: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 15,
                                ),
                                hintText: '',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Divider(
                          height: 1,
                          color: grey120,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          AppLocalizations.of(context)!.financial_expenses,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .financial_house
                                .toUpperCase(),
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                          Expanded(
                            child: TextFormField(
                              textAlign: TextAlign.right,
                              controller: _houseCosts,
                              readOnly: false,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CurrencyFormatter(),
                              ],
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: formatter.format(
                                    int.parse(houseCosts.toString()) / 100),
                                hintStyle: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .financial_transport
                                .toUpperCase(),
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                          Expanded(
                            child: TextFormField(
                              textAlign: TextAlign.right,
                              controller: _transportCosts,
                              readOnly: false,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CurrencyFormatter(),
                              ],
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: formatter.format(
                                    int.parse(transportCosts.toString()) / 100),
                                hintStyle: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .financial_utilities
                                .toUpperCase(),
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                          Expanded(
                            child: TextFormField(
                              textAlign: TextAlign.right,
                              controller: _utilityCosts,
                              readOnly: false,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CurrencyFormatter(),
                              ],
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: formatter.format(
                                    int.parse(utilityCosts.toString()) / 100),
                                hintStyle: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .financial_another_expenses
                                .toUpperCase(),
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                          Expanded(
                            child: TextFormField(
                              textAlign: TextAlign.right,
                              controller: _otherCosts,
                              readOnly: false,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CurrencyFormatter(),
                              ],
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: formatter.format(
                                    int.parse(otherCosts.toString()) / 100),
                                hintStyle: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() => _financialDataController.isLoading.value == false
            ? SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: _isButtonEnabled ? _postFinancial : null,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: _isButtonEnabled ? secondaryColor : Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    child: Text(
                      AppLocalizations.of(context)!.confirm.toUpperCase(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: secondaryColor,
                ),
              )),
      ),
    );
  }

  _postFinancial() async {
    String groupId = widget.groupID ?? '';
    int incomeValue = int.parse(_income.text.replaceAll(RegExp(r'[^0-9]'), ''));
    String peopleFamily = _familySize.text;
    String house = selectedHomeType.toString();
    String transport = selectedTransport.toString();
    int houseCostValue =
        int.parse(_houseCosts.text.replaceAll(RegExp(r'[^0-9]'), ''));
    int transportCostValue =
        int.parse(_transportCosts.text.replaceAll(RegExp(r'[^0-9]'), ''));
    int utilitiesCostValue =
        int.parse(_utilityCosts.text.replaceAll(RegExp(r'[^0-9]'), ''));
    int otherCostsValue =
        int.parse(_otherCosts.text.replaceAll(RegExp(r'[^0-9]'), ''));

    String income = (incomeValue / 100).toString();
    String houseCost = (houseCostValue / 100).toString();
    String transportCost = (transportCostValue / 100).toString();
    String utilitiesCost = (utilitiesCostValue / 100).toString();
    String otherCosts = (otherCostsValue / 100).toString();

    await SharedPreferencesFunctions.saveString(
        key: 'familySize', value: peopleFamily);

    try {
      await _financialDataController.financialData(
          groupId,
          income,
          peopleFamily,
          house,
          transport,
          houseCost,
          transportCost,
          utilitiesCost,
          otherCosts);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
