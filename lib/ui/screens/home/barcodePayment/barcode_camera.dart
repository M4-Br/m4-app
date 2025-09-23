import 'package:app_flutter_miban4/ui/controllers/barcode/barcode_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../colors/app_colors.dart';

class BarcodeCamera extends StatefulWidget {
  const BarcodeCamera({super.key});

  @override
  State<BarcodeCamera> createState() => _BarcodeCameraState();
}

class _BarcodeCameraState extends State<BarcodeCamera> {
  final BarcodeController _barcodeController = Get.put(BarcodeController());

  final controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    controller.dispose();
    _barcodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear Código de Barras'),
      ),
      body: Obx(
        () => _barcodeController.isLoading.value == true
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
                          _barcodeController.barcodeDecode(code);
                        }
                      }
                    },
                  ),
                  Container(color: Colors.black.withOpacity(0.5)),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.2,
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
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        const Text(
                          "Aponte a câmera para o Código de Barras",
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
