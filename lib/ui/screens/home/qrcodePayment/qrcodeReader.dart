import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/controllers/qrcode/qrcode_controller.dart';
import 'package:app_flutter_miban4/ui/screens/home/home_view_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/qrcodePayment/qrCodeView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/api/balance/balanceAPI.dart';
import '../../../../data/api/qrcode/decodeCode.dart';
import '../../../../data/model/qrCode/decodeQRCode.dart';
import '../pix/pixAddValue.dart';
import '../pix/pixCodeDecode.dart';

class QrCodeReader extends StatefulWidget {
  const QrCodeReader({super.key});

  @override
  State<QrCodeReader> createState() => _QrCodeReaderState();
}

class _QrCodeReaderState extends State<QrCodeReader> {
  final QrcodeController _qrcodeController = Get.put(QrcodeController());

  String qrCode = '';
  var isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarDefault(
        title: 'PIX',
        backPage: () => Get.off(() => const HomeViewPage(),
            transition: Transition.leftToRight),
      ),
      body: Obx(() {
        return _qrcodeController.isLoading.value == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'qr_code_error'.tr,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _scanQrCode,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(45),
                          ),
                        ),
                        child: Text(
                          'qr_code_try_again'.tr,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
              );
      }),
    );
  }

  Future<void> _scanQrCode() async {
    Get.to(() => QrCodeView(onScanned: (String scannedCode) async {
          Get.back();
          isLoading(true);
          try {
            qrCode = scannedCode;
            final balance = await getBalance();
            DecodeQRCode paymentData = await decodeCode(qrCode);

            if (paymentData.finalAmount != 0) {
              isLoading(false);
              Get.off(
                  () => PixCodeDecode(
                        qrCode: paymentData,
                        balance: balance,
                      ),
                  transition: Transition.rightToLeft);
            } else {
              isLoading(false);
              Get.off(
                  () => PixAddValue(
                        qrCode: paymentData,
                        balance: balance,
                      ),
                  transition: Transition.rightToLeft);
            }
          } catch (error) {
            isLoading(false);
            throw Exception(error.toString());
          }
        }));
  }
}
