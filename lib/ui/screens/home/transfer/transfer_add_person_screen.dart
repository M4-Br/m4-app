import 'package:app_flutter_miban4/data/api/balance/balanceAPI.dart';
import 'package:app_flutter_miban4/data/model/userData/balance.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_value_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_another_bank_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:mask_shifter_v2/mask_shifter.dart';

class TransferAddPersonScreen extends StatefulWidget {
  final Map<String, dynamic>? userTransfer;
  final String code;
  final String bank;
  final int type;
  final String document;

  const TransferAddPersonScreen({
    super.key,
    required this.userTransfer,
    required this.code,
    required this.bank,
    required this.type,
    required this.document,
  });

  @override
  State<TransferAddPersonScreen> createState() =>
      _TransferAddPersonScreenState();
}

class _TransferAddPersonScreenState extends State<TransferAddPersonScreen> {
  final _formKey = GlobalKey<FormState>();
  final _documentController = TextEditingController();
  final _nameController = TextEditingController();
  final _bankController = TextEditingController();
  final _agencyController = TextEditingController();
  final _agencyDigitController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _accountDigitController = TextEditingController();
  String _selectedType = '';
  bool _isButtonEnabled = false;
  String _accountType = '';

  @override
  void initState() {
    super.initState();
    _documentController.text = widget.document;
    _bankController.text = widget.bank;

    // Add listeners to text controllers
    _nameController.addListener(_updateButtonState);
    _agencyController.addListener(_updateButtonState);
    _accountNumberController.addListener(_updateButtonState);
    _accountDigitController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _nameController.text.isNotEmpty &&
          _documentController.text.isNotEmpty &&
          _bankController.text.isNotEmpty &&
          _agencyController.text.isNotEmpty &&
          _accountNumberController.text.isNotEmpty &&
          _accountDigitController.text.isNotEmpty &&
          _selectedType.isNotEmpty;
    });
  }

  @override
  void dispose() {
    // Dispose of the controllers
    _nameController.dispose();
    _documentController.dispose();
    _bankController.dispose();
    _agencyController.dispose();
    _accountNumberController.dispose();
    _accountDigitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(
        title: AppLocalizations.of(context)!.transfer_add_person.toUpperCase(),
        backPage: () => Get.off(
            () => TransferAnotherBankScreen(
                  userTransfer: widget.userTransfer,
                  document: widget.document,
                  type: widget.type,
                ),
            transition: Transition.leftToRight),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextFormField(
                    cursorColor: secondaryColor,
                    validator: (value) => value!.isEmpty
                        ? AppLocalizations.of(context)!.validator_empty
                        : null,
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: secondaryColor),
                      ),
                      errorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      contentPadding: EdgeInsets.zero,
                      labelText: AppLocalizations.of(context)!.name,
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      hintText: '',
                    ),
                  ),
                ),
                TextFormField(
                  readOnly: true,
                  cursorColor: secondaryColor,
                  controller: _documentController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                  inputFormatters: [
                    MaskedTextInputFormatterShifter(
                        maskONE: "XXX.XXX.XXX-XX",
                        maskTWO: "XX.XXX.XXX/XXXX-XX")
                  ],
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: secondaryColor),
                    ),
                    errorBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    contentPadding: EdgeInsets.zero,
                    labelText: AppLocalizations.of(context)!.document,
                    labelStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    hintText: '',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: TextFormField(
                    readOnly: true,
                    cursorColor: secondaryColor,
                    controller: _bankController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: secondaryColor),
                      ),
                      errorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      contentPadding: EdgeInsets.zero,
                      labelText: AppLocalizations.of(context)!.account_bank,
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      hintText: '',
                    ),
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: TextFormField(
                        cursorColor: secondaryColor,
                        controller: _agencyController,
                        keyboardType: TextInputType.number,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: secondaryColor),
                          ),
                          errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          contentPadding: EdgeInsets.zero,
                          labelText: AppLocalizations.of(context)!.bank_agency,
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          hintText: '',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                        cursorColor: secondaryColor,
                        controller: _agencyDigitController,
                        keyboardType: TextInputType.number,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: secondaryColor),
                          ),
                          errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          contentPadding: EdgeInsets.zero,
                          labelText:
                              AppLocalizations.of(context)!.bank_agency_digit,
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          hintText: '',
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: DropdownButtonFormField<String>(
                    value: _selectedType.isEmpty ? null : _selectedType,
                    icon: const Icon(Icons.keyboard_arrow_down_outlined),
                    elevation: 16,
                    isExpanded: true,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context)!.bank_account_type,
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      border: InputBorder.none,
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      errorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    items: <String>[
                      'Conta Corrente',
                      'Conta Poupança',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedType = value!;
                        value == 'Conta Corrente'
                            ? _accountType == 'cc'
                            : _accountType == 'cp';
                        _updateButtonState();
                      });
                    },
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        cursorColor: secondaryColor,
                        controller: _accountNumberController,
                        keyboardType: TextInputType.number,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: secondaryColor),
                          ),
                          errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          contentPadding: EdgeInsets.zero,
                          labelText:
                              AppLocalizations.of(context)!.bank_account_number,
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          hintText: '',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Flexible(
                      child: TextFormField(
                        cursorColor: secondaryColor,
                        controller: _accountDigitController,
                        keyboardType: TextInputType.number,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: secondaryColor),
                          ),
                          errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          contentPadding: EdgeInsets.zero,
                          labelText:
                              AppLocalizations.of(context)!.bank_account_digit,
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          hintText: '',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 45,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isButtonEnabled
                ? () async {
                    Balance balance = await getBalance();
                    Get.to(
                        () => TransferValuePage(
                              userTransfer: widget.userTransfer,
                              balance: balance,
                              bank: _bankController.text,
                              type: widget.type,
                              document: widget.document,
                              from: 1,
                              name: _nameController.text,
                              agency: _agencyController.text,
                              accountType: _selectedType,
                              accountNumber: _accountNumberController.text,
                              accountDigit: _accountDigitController.text,
                              code: widget.code,
                            ),
                        transition: Transition.rightToLeft);
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _isButtonEnabled ? secondaryColor : Colors.grey,
            ),
            child: Text(
              AppLocalizations.of(context)!.bank_add_account.toUpperCase(),
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
