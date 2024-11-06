import 'package:app_flutter_miban4/data/api/balance/balanceAPI.dart';
import 'package:app_flutter_miban4/data/api/barcode/decodeBarcode.dart';
import 'package:app_flutter_miban4/data/model/barcode/decodeBarcode.dart';
import 'package:app_flutter_miban4/data/model/userData/balance.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/home/barcodePayment/barcodeConfirmPayment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:mask_shifter_v2/mask_shifter.dart';

class BarcodeScanScreen extends StatefulWidget {
  const BarcodeScanScreen({super.key});

  @override
  State<BarcodeScanScreen> createState() => _BarcodeScanScreenState();
}

class _BarcodeScanScreenState extends State<BarcodeScanScreen> {
  String barcode = '';
  final _controller = TextEditingController();
  var isLoading = false.obs;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(
        title: 'pay_barcode'.tr,
        backPage: () => Get.back(),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                controller: _controller,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.black, fontSize: 20),
                inputFormatters: [
                  MaskedTextInputFormatterShifter(
                      maskONE:
                          "XXXXXXXXXXXX XXXXXXXXXXXX XXXXXXXXXXXX XXXXXXXXXXXX",
                      maskTWO:
                          "XXXXX.XXXXX XXXXX.XXXXXX XXXXX.XXXXXX X XXXXXXXXXXXXXXXXX")
                ],
                decoration: InputDecoration(
                  floatingLabelStyle: const TextStyle(color: secondaryColor),
                  isDense: true,
                  border: InputBorder.none,
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  contentPadding: EdgeInsets.zero,
                  labelText: 'barcode_barcode'.tr,
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                  hintText: '',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      _manualBarcode();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor),
                    child: Text(
                      'continue_barcode'
                          .toUpperCase().tr,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      _scanBarcode();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor),
                    child: Text(
                      'barcode_auto'.toUpperCase().tr,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Image.asset(
                'assets/icons/ic_schedule.png',
                width: 100,
                color: secondaryColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'barcode_info'.tr,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'barcode_info_after'.tr,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            Obx(
              () => isLoading.value == true
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 50),
                      child: CircularProgressIndicator(
                        color: secondaryColor,
                      ),
                    )
                  : const SizedBox(),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _scanBarcode() async {
    isLoading(true);
    barcode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE);

    try {
      Balance balance = await getBalance();
      PaymentData paymentData = await decodeBarcode(barcode);

      if (paymentData.success == true) {
        Get.off(
            () => BarcodeConfirmPayment(
                paymentData: paymentData, balance: balance),
            transition: Transition.rightToLeft);
      } else {
        return;
      }
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> _manualBarcode() async {
    isLoading(true);

    try {
      barcode = _controller.text.toString();
      Balance balance = await getBalance();
      PaymentData paymentData = await decodeBarcode(barcode);
      Get.off(
          () =>
              BarcodeConfirmPayment(paymentData: paymentData, balance: balance),
          transition: Transition.rightToLeft);
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
