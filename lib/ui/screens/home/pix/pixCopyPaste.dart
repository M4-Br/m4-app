import 'package:app_flutter_miban4/data/model/userData/balance.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/controllers/qrcode/qrcode_controller.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixHome.dart';
import 'package:app_flutter_miban4/ui/screens/home/qrcodePayment/qr_code_camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PixCopyPaste extends StatefulWidget {
  late Balance? balance;

  PixCopyPaste({Key? key, this.balance}) : super(key: key);

  @override
  State<PixCopyPaste> createState() => _PixCopyPasteState();
}

class _PixCopyPasteState extends State<PixCopyPaste> {
  final TextEditingController _controller = TextEditingController();
  final QrcodeController _qrcodeController = Get.put(QrcodeController());

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat =
        NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return Scaffold(
      appBar: AppBarDefault(
        title: 'pix_copyAndPaste'.tr,
        backPage: () =>
            Get.off(() => PixHome(), transition: Transition.leftToRight),
        rightIcon: IconButton(
          icon: const Icon(
            Icons.qr_code_2_outlined,
            color: Colors.white,
          ),
          onPressed: () => Get.to(() => const QrCodeCamera(),
              transition: Transition.rightToLeft),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'pix_pasteCode'.tr,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'pix_code'.tr,
                labelStyle: const TextStyle(color: Colors.grey),
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
            ),
            const Spacer(),
            Text(
              '${'balance_available'.tr} R\$ ${currencyFormat.format((int.parse(widget.balance!.balanceCents!) / 100))}',
              style: const TextStyle(color: Colors.black, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.off(() => PixHome(),
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
                      'cancel'.tr.toUpperCase(),
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Obx(
                    () => _qrcodeController.isLoading.value == false
                        ? ElevatedButton(
                            onPressed: () => _qrcodeController
                                .decodeCopyPaste(_controller.text.toString()),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  _controller.text.toString().length >= 10
                                      ? secondaryColor
                                      : Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              'proceed'.tr,
                              style: TextStyle(
                                  color: _controller.text.length >= 10
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 16),
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                              color: secondaryColor,
                            ),
                          ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
