import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/features/qrCodeCamera/controller/qrcode_camera_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodeCameraPage extends GetView<QrCodeCameraController> {
  const QrCodeCameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear QR Code',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: controller.cameraController,
            onDetect: controller.onDetect,
            errorBuilder: (context, error) {
              return const Center(
                child: Text(
                  'Erro ao iniciar câmera',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          ),
          _buildOverlay(context),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCircleButton(
                        icon: Icons.close,
                        onPressed: () => Get.back(),
                      ),
                      _buildCircleButton(
                        icon: Icons.flash_on,
                        onPressed: controller.toggleTorch,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                const Text(
                  'Aponte a câmera para o QR Code',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      shadows: [Shadow(color: Colors.black, blurRadius: 4)]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: SizedBox(
                    height: 45,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor.withOpacity(0.8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                      ),
                      onPressed: controller.switchCamera,
                      icon: const Icon(Icons.cameraswitch_outlined,
                          color: Colors.white),
                      label: const Text(
                        'Trocar câmera',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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

  Widget _buildOverlay(BuildContext context) {
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
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
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
          border: Border.all(color: Colors.white54)),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }
}
