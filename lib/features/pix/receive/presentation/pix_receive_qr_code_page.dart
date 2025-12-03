import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/pix/receive/controller/pix_receive_qr_code_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PixReceiveQrCodePage extends GetView<PixReceiveQrCodeController> {
  const PixReceiveQrCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'pix_receiver'.tr,
        onBackPressed: () => controller.backUntil(),
      ),
      body: Column(
        children: [
          // --- PARTE SUPERIOR (BRANCA) ---
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              // CORREÇÃO: Adicionado Center e SingleChildScrollView
              // Isso garante que se o conteúdo for grande, ele rola e não quebra (overflow).
              // O Center mantém centralizado se sobrar espaço.
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize:
                        MainAxisSize.min, // Importante para o Center funcionar
                    children: [
                      RepaintBoundary(
                        key: controller.shareQrKey,
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          color: Colors.white,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: grey120, width: 8),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: QrImageView(
                                  data: controller.qrCodeData.emv,
                                  version: QrVersions.auto,
                                  size: 150.0,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      AppText.titleLarge(
                        context,
                        'pix_codeGenerated'.tr,
                      ),
                      const SizedBox(height: 8),
                      AppText.bodyMedium(context, 'pix_dataVisible'.tr,
                          textAlign: TextAlign.center),

                      // Certifique-se que gapM está importado ou troque por SizedBox
                      const SizedBox(height: 24), // gapM aproximado

                      Row(
                        children: [
                          Expanded(
                            child: _buildActionButton(
                              label: 'pix_copyLink'.tr,
                              onPressed: controller.copyToClipboard,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildActionButton(
                              label: 'pix_shareCode'.tr,
                              onPressed: controller.shareCode,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // --- PARTE INFERIOR (CINZA) ---
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              color: const Color(0xFFe9eaf0),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: controller.receiveAnother,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'pix_receiveAnother'.tr,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: controller.saveToGallery,
                    child: Text(
                      'pix_saveDevice'.tr,
                      style: const TextStyle(color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      {required String label, required VoidCallback onPressed}) {
    return SizedBox(
      height: 45,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: grey120,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.black87),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
