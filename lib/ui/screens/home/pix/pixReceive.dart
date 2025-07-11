import 'package:app_flutter_miban4/data/api/pix/pixKeys.dart';
import 'package:app_flutter_miban4/data/model/pix/pixKeys.dart';
import 'package:app_flutter_miban4/data/model/pix/pixReceiveQRCode.dart';
import 'package:app_flutter_miban4/data/util/helpers/mask.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/controllers/pix/pix_receive_controller.dart';
import 'package:app_flutter_miban4/ui/screens/home/home_view_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixHome.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixKeyManager.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixQRCodeReceive.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PixReceive extends StatefulWidget {
  final int? type;

  const PixReceive({Key? key, this.type}) : super(key: key);

  @override
  State<PixReceive> createState() => _PixReceiveState();
}

class _PixReceiveState extends State<PixReceive> {
  final TextEditingController _description = TextEditingController();
  final TextEditingController _identifier = TextEditingController();
  final TextEditingController _amountValue = TextEditingController();
  String? _selectedKey;
  final PixReceiveController _receiveController =
      Get.put(PixReceiveController());
  List<String> _apikeys = [];

  late Future<PixKeys> _pixKeysFuture;

  @override
  void initState() {
    super.initState();
    _pixKeysFuture = fetchPixKeys();
  }

  @override
  void dispose() {
    _description.dispose();
    _identifier.dispose();
    _amountValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBarDefault(
        title: 'pix_receiver'.tr,
        backPage: () => widget.type == 0
            ? Get.off(() => PixHome(), transition: Transition.leftToRight)
            : widget.type == 1
                ? Get.off(() => const HomeViewPage(), transition: Transition.leftToRight)
                : Get.back(),
      ),
      body: FutureBuilder<PixKeys>(
        future: _pixKeysFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Erro na chamada de API'),
            );
          } else {
            PixKeys keys = snapshot.data!;

            final List<String> allKeys = [];

            for (var phone in keys.phones) {
              allKeys.add(phone.key);
            }

            for (var document in keys.documents) {
              allKeys.add(MaskUtil.applyMask(document.key, '###.###.###-##'));
            }

            for (var email in keys.emails) {
              allKeys.add(email.key);
            }

            for (var evp in keys.evps) {
              allKeys.add(evp.key);
            }

            _apikeys = allKeys.toList();
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text:
                                  'pix_selectKey'.tr),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.to(
                                  () => const PixKeyManager(),
                                  transition: Transition.rightToLeft),
                            text: 'pix_nKey'.tr,
                            style: const TextStyle(
                                color: secondaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.info_outline,
                        size: 20,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: DropdownButton<String>(
                    value: _selectedKey,
                    hint: Text('pix_keySelect'.tr),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedKey = newValue;
                      });
                    },
                    items:
                        _apikeys.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'pix_optional'.tr,
                      style: const TextStyle(fontSize: 14),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.info_outline_rounded,
                        size: 16,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextField(
                    controller: _identifier,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                      contentPadding: EdgeInsets.zero,
                      labelText: 'pix_identifier'.tr,
                      labelStyle: const TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                      hintText: '',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: TextField(
                    controller: _description,
                    maxLength: 72,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                    decoration: InputDecoration(
                      counterText: '72 caracteres disponíveis',
                      isDense: true,
                      border: InputBorder.none,
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                      contentPadding: EdgeInsets.zero,
                      labelText: 'pix_description'.tr,
                      labelStyle: const TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                      hintText: '',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextField(
                    controller: _amountValue,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        final text =
                            MaskUtil.applyMask(newValue.text, '###.###,##');
                        _amountValue.value = _amountValue.value.copyWith(
                          text: text,
                          selection:
                              TextSelection.collapsed(offset: text.length),
                        );
                        return _amountValue.value;
                      }),
                    ],
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black54),
                      ),
                      contentPadding: EdgeInsets.zero,
                      labelText: 'pix_value'.tr,
                      labelStyle: const TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                      hintText: '',
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Obx(
                      () => _receiveController.codeLoading.value == false
                          ? ElevatedButton(
                              onPressed: () async {
                                if (_amountValue.text.isNotEmpty ||
                                    _identifier.text.isNotEmpty) {
                                  try {
                                    String key = _selectedKey.toString();
                                    String amount = _amountValue.text
                                        .replaceAll('.', '')
                                        .replaceAll(',', '');
                                    String title = _identifier.text.toString();
                                    String description =
                                        _description.text.toString();
                                    CreatePIXQrCode? qrcode =
                                        await _receiveController.createCode(
                                            key, amount, title, description);

                                    if (qrcode!.success == true) {
                                      Get.to(
                                          () =>
                                              PixQRCodeReceive(qrCode: qrcode),
                                          transition: Transition.rightToLeft);
                                    }
                                  } catch (e) {
                                    throw Exception(e.toString());
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: secondaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                'next'.tr,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(
                                color: secondaryColor,
                              ),
                            ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
