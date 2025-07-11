import 'package:app_flutter_miban4/data/api/balance/balanceAPI.dart';
import 'package:app_flutter_miban4/data/api/pix/pixValidateKey.dart';
import 'package:app_flutter_miban4/data/model/userData/balance.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/controllers/pix/pix_with_key_controller.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixHome.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixManualKey.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixTransfer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class PixWithKey extends StatefulWidget {
  const PixWithKey({Key? key}) : super(key: key);

  @override
  State<PixWithKey> createState() => _PixWithKeyState();
}

class _PixWithKeyState extends State<PixWithKey> {
  String dropdownValue = 'Selecione um tipo';
  String? selectedValue;
  Color _buttonColor = Colors.grey;
  bool _showProgress = false;
  final TextEditingController _controller = TextEditingController();
  final PixWithKeyController _keyController = Get.put(PixWithKeyController());

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarDefault(
        title: 'pix_withKey'.tr,
        backPage: () =>
            Get.off(() => PixHome(), transition: Transition.leftToRight),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'pix_addReceiverKey'.tr,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'pix_keyType'.tr,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            DropdownButton(
              value: dropdownValue,
              items: <String>[
                'Selecione um tipo',
                'Chave Aleatória',
                'Email',
                'Celular',
                'CPF/CNPJ'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                  selectedValue = newValue;
                });
              },
            ),
            TextField(
              controller: _controller,
              onChanged: (value) {
                setState(() {
                  if (selectedValue == 'CPF/CNPJ' && value.length >= 11) {
                    _buttonColor = secondaryColor;
                  } else if (selectedValue == "Celular" && value.length >= 11) {
                    _buttonColor = secondaryColor;
                  } else if (selectedValue == 'Email' &&
                      value.contains('.com')) {
                    _buttonColor = secondaryColor;
                  } else if (selectedValue == 'Chave Aleatória') {
                    _buttonColor = secondaryColor;
                  } else {
                    _buttonColor = Colors.grey;
                  }
                });
              },
              decoration: InputDecoration(
                labelText: 'pix_labelKey'.tr,
                border: const UnderlineInputBorder(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Visibility(
                  visible: _showProgress,
                  child: const CircularProgressIndicator(
                    color: Colors.black54,
                  )),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: SizedBox(
                width: double.infinity,
                height: 45,
                child: Obx(() => _keyController.isLoading.value == false
                    ? ElevatedButton(
                        onPressed: () => _keyController
                            .searchKey(_controller.text.toString()),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: _buttonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'pix_search'.tr,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                          color: secondaryColor,
                        ),
                      )),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const PixManualKey(),
                      transition: Transition.rightToLeft);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'pix_agencyAccount'.tr,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
