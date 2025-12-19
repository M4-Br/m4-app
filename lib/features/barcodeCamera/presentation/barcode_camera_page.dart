import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/features/barcodeCamera/controller/barcode_camera_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeCameraPage extends GetView<BarcodeCameraController> {
  const BarcodeCameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scanWindowWidth = size.width * 0.7;
    final scanWindowHeight = size.height * 0.4;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Câmera
          MobileScanner(
            controller: controller.cameraController,
            onDetect: controller.onDetect,
            errorBuilder: (context, error) {
              return const Center(
                  child: Text('Erro na câmera',
                      style: TextStyle(color: Colors.white)));
            },
          ),
          _buildOverlay(scanWindowWidth, scanWindowHeight),
          SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: 16,
                  left: 16,
                  child: _buildCircleButton(
                    icon: Icons.close,
                    onPressed: () => Get.back(),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: _buildCircleButton(
                    icon: Icons.flash_on,
                    onPressed: controller.toggleTorch,
                  ),
                ),
                Center(
                  child: Container(
                    width: scanWindowWidth * 0.9,
                    height: 2,
                    color: Colors.redAccent.withValues(alpha: 0.7),
                  ),
                ),
                Positioned(
                  bottom: 24,
                  left: 0,
                  right: 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Alinhe o código de barras na linha vermelha',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        height: 45,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.white.withValues(alpha: 0.2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            side: const BorderSide(
                                color: Colors.white54, width: 1),
                          ),
                          onPressed: () => controller.manualCode(),
                          icon: const Icon(Icons.keyboard_alt_outlined,
                              color: Colors.white),
                          label: const Text('Digitar código',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 45,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                primaryColor.withValues(alpha: 0.8),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: controller.switchCamera,
                          icon: const Icon(Icons.cameraswitch_outlined,
                              color: Colors.white),
                          label: const Text('Trocar câmera',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 4. Loading Overlay
          Obx(() {
            if (controller.isLoading.value) {
              return Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(color: secondaryColor),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  Widget _buildOverlay(double width, double height) {
    return ColorFiltered(
      colorFilter: const ColorFilter.mode(
        Colors.black54,
        BlendMode.srcOut,
      ),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              backgroundBlendMode: BlendMode.dstOut,
            ),
          ),
          Center(
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: Colors.black, // Cor recortada
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton(
      {required IconData icon, required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black45,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white54),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }
}
