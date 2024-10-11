import 'package:app_flutter_miban4/data/api/pix/bankList.dart';
import 'package:app_flutter_miban4/data/model/pix/banks_model.dart';
import 'package:app_flutter_miban4/data/model/userData/balance.dart';
import 'package:app_flutter_miban4/data/model/userData/user.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixHome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PixManualKey extends StatefulWidget {
  const PixManualKey({Key? key}) : super(key: key);

  @override
  State<PixManualKey> createState() => _PixManualKeyState();
}

class _PixManualKeyState extends State<PixManualKey> {
  String? _selectedAccountType;
  final List<String> _accountTypes = [
    'Selecione seu tipo de conta',
    'Conta Corrente',
    'Conta Poupança',
    'Conta de Pagamento'
  ];

  String bankSelected = '';
  String bankCode = '';

  final TextEditingController _name = TextEditingController();
  final TextEditingController _document = TextEditingController();
  final TextEditingController _bank = TextEditingController();
  final TextEditingController _ag = TextEditingController();
  final TextEditingController _account = TextEditingController();
  final TextEditingController _accountDigit = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _document.dispose();
    _ag.dispose();
    _account.dispose();
    _accountDigit.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(
        title: 'PIX COM CHAVE MANUAL',
        backPage: () =>
            Get.off(() => PixHome(), transition: Transition.leftToRight),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: _name,
              decoration: const InputDecoration(
                labelText: 'Nome ou razão social',
                labelStyle: TextStyle(color: Colors.grey),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF002A4D)),
                ),
              ),
            ),
            TextField(
              controller: _document,
              keyboardType: const TextInputType.numberWithOptions(),
              decoration: const InputDecoration(
                labelText: 'CPF/CNPJ do titular',
                labelStyle: TextStyle(color: Colors.grey),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF002A4D)),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              readOnly: true,
              onTap: () async {
                List<BankList> bankList = await getBanks();
                _showBankList(bankList);
              },
              onChanged: (String value) {
                setState(() {
                  bankSelected = value;
                });
              },
              controller: _bank,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                contentPadding: EdgeInsets.zero,
                labelText: 'Banco',
                suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined),
                labelStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
                hintText: "",
              ),
            ),
            DropdownButton<String>(
              isExpanded: true,
              hint: const Text(
                'Tipo de conta',
                style: TextStyle(color: Colors.grey),
              ),
              icon: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: Colors.grey,
                ),
              ),
              value: _selectedAccountType,
              items: _accountTypes.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedAccountType = newValue;
                });
              },
            ),
            TextField(
              controller: _ag,
              keyboardType: const TextInputType.numberWithOptions(),
              decoration: const InputDecoration(
                labelText: 'Número da agência',
                labelStyle: TextStyle(color: Colors.grey),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF002A4D)),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _account,
                    keyboardType: const TextInputType.numberWithOptions(),
                    decoration: const InputDecoration(
                      labelText: 'Número da Conta',
                      labelStyle: TextStyle(color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF002A4D)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: TextField(
                    controller: _accountDigit,
                    keyboardType: const TextInputType.numberWithOptions(),
                    decoration: const InputDecoration(
                      labelText: 'Dígito da Conta',
                      labelStyle: TextStyle(color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF002A4D)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            TextField(
              controller: _description,
              maxLength: 72,
              decoration: const InputDecoration(
                labelText: 'Descrição (opcional)',
                labelStyle: TextStyle(color: Colors.grey),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF002A4D)),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'PROSSEGUIR',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBankList(List<BankList> bankList) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bancos'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: bankList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(bankList[index].name),
                    onTap: () {
                      setState(() {
                        bankSelected = bankList[index].name;
                        bankCode = bankList[index].code;
                        _bank.text = bankSelected;
                      });
                      Navigator.pop(context);
                    },
                  );
                },
                separatorBuilder: (_, index) => const Divider(
                      color: Colors.black87,
                    )),
          ),
        );
      },
    );
  }
}
