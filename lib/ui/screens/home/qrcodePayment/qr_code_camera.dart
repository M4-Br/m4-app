import 'package:app_flutter_miban4/ui/controllers/qrcode/qrcode_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../colors/app_colors.dart';

class QrCodeCamera extends StatefulWidget {
  const QrCodeCamera({super.key});

  @override
  State<QrCodeCamera> createState() => _QrCodeCameraState();
}

class _QrCodeCameraState extends State<QrCodeCamera> {
  final controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  final QrcodeController _qrcodeController = Get.put(QrcodeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear QR Code'),
      ),
      body: Obx(
        () => _qrcodeController.isLoading.value == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: secondaryColor,
                ),
              )
            : Stack(
                children: [
                  MobileScanner(
                    controller: controller,
                    onDetect: (barcodeCapture) {
                      final List<Barcode> barcodes = barcodeCapture.barcodes;
                      if (barcodes.isNotEmpty) {
                        final String? code = barcodes.first.rawValue;
                        if (code != null) {
                          _qrcodeController.scanQrCode(code);
                        }
                      }
                    },
                  ),
                  // Máscara
                  Container(color: Colors.black.withOpacity(0.5)),
                  Center(
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () {
                            controller.stop();
                            Get.back();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.flash_on, color: Colors.white),
                          onPressed: () {
                            controller.toggleTorch();
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        const Text(
                          "Aponte a câmera para o QR Code",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor),
                          onPressed: () => controller.switchCamera(),
                          child: const Text(
                            "Trocar câmera",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
