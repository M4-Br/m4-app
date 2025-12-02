import 'package:app_flutter_miban4/data/model/pix/pixValidateKey.dart';
import 'package:app_flutter_miban4/data/model/userData/balance.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/controllers/pix/send_pix_controller.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixWithKey.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PixTransfer extends StatefulWidget {
  late ValidateKey? pix;
  late Balance? balance;

  PixTransfer({super.key, this.pix, this.balance});

  @override
  State<PixTransfer> createState() => _PixTransferState();
}

class _PixTransferState extends State<PixTransfer> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: '');
  final SendPixController _sendPixController = Get.put(SendPixController());

  var _obscureText = true.obs;

  String _format(String number) {
    if (number.length > 11) {
      return "${number.substring(0, 2)}."
          "${number.substring(2, 5)}."
          "${number.substring(5, 8)}/"
          "${number.substring(8, 12)}-"
          "${number.substring(12)}";
    } else {
      return "${number.substring(0, 3)}."
          "${number.substring(3, 6)}."
          "${number.substring(6, 9)}-"
          "${number.substring(9)}";
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(
        title: 'pix_withKey'.tr,
        backPage: () => Get.off(() => const PixWithKey(),
            transition: Transition.leftToRight),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Text(
                'pix_payValue'.tr,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 36),
                child: TextField(
                  controller: _controller,
                  style: const TextStyle(
                      color: secondaryColor,
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
              TextField(
                controller: _description,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                  counterStyle: const TextStyle(color: secondaryColor),
                  hintText: 'pix_descriptionTransfer'.tr,
                  hintStyle: const TextStyle(color: Colors.black),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  contentPadding: const EdgeInsets.only(bottom: 8),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    Text(
                      'pix_transferDate'.tr,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () => _selectDate(context),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today),
                          const SizedBox(width: 8.0),
                          Text(
                            "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    Text(
                      'pix_keyKey'.tr,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Spacer(),
                    Text(
                      widget.pix!.key,
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    'pix_receiverTransfer'.tr,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  Text(
                    widget.pix!.name.length > 18
                        ? '${widget.pix!.name.substring(0, 18)}...'
                        : widget.pix!.name,
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    const Text(
                      "CPF/CNPJ",
                      style: TextStyle(fontSize: 16),
                    ),
                    const Spacer(),
                    Text(
                      _format(widget.pix!.nationalRegistration.toString()),
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    'pix_institution'.tr,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  Expanded(
                    child: Text(
                      widget.pix!.bankName,
                      style: const TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 7,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${'balance_available'.tr}: ",
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        "R\$ ${currencyFormat.format(double.parse(widget.balance!.balanceCents) / 100)}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                          onPressed: () => Get.off(() => const PixWithKey(),
                              transition: Transition.leftToRight),
                          child: Text(
                            'cancel'.tr.toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: _doTransfer,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: secondaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: Text(
                          'pay'.tr,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  _doTransfer() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: Text(
            'password_insert'.tr,
            textAlign: TextAlign.center,
          ),
          content: Obx(
            () => TextField(
              controller: _controllerPassword,
              keyboardType: TextInputType.number,
              maxLength: 6,
              obscureText: _obscureText.value,
              decoration: InputDecoration(
                suffixIcon: Obx(
                  () => IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText.value = !_obscureText.value;
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
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'cancel'.tr,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String amount = _controller.text
                              .replaceAll('R\$', '')
                              .replaceAll('.', '')
                              .replaceAll(',', '');
                          String description = _description.text.toString();
                          String idEndtoEnd = widget.pix!.idEndToEnd;
                          String password = _controllerPassword.text;
                          String idTxt = '';
                          int transferType = 1;
                          String bankNumber = widget.pix!.bankAccountNumber;
                          String bankAccountType = widget.pix!.bankAccountType;
                          String bankBranch = widget.pix!.bankBranchNumber;
                          String beneficiaryType = widget.pix!.beneficiaryType;
                          String document = widget.pix!.nationalRegistration;
                          String ispb = widget.pix!.ispb;
                          String name = widget.pix!.name;
                          String key = widget.pix!.key;

                          final formattedDate =
                              DateFormat('yyyy-MM-dd').format(_selectedDate);

                          _sendPixController.pixTransfer(
                              amount,
                              description,
                              idEndtoEnd,
                              password,
                              idTxt,
                              bankNumber,
                              bankAccountType,
                              bankBranch,
                              beneficiaryType,
                              document,
                              ispb,
                              name,
                              key,
                              transferType,
                              widget.pix!.bankName,
                              formattedDate);

                          return AlertDialog.adaptive(
                            title: Text(
                              'wait'.tr,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                            content: const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: secondaryColor,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      'confirm'.tr,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class CurrencyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(
          text: '0,00', selection: const TextSelection.collapsed(offset: 6));
    }

    final double amount = double.parse(newValue.text) / 100;

    final String newText = 'R\$ ${amount.toStringAsFixed(2)}';
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
