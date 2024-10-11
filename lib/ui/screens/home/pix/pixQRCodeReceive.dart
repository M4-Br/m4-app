import 'dart:convert';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:app_flutter_miban4/data/model/pix/pixReceiveQRCode.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixReceive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:share/share.dart';

class PixQRCodeReceive extends StatefulWidget {
  final CreatePIXQrCode? qrCode;
  final int? type;

  PixQRCodeReceive({Key? key, this.qrCode, this.type}) : super(key: key);

  @override
  State<PixQRCodeReceive> createState() => _PixQRCodeReceiveState();
}

class _PixQRCodeReceiveState extends State<PixQRCodeReceive> {
  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Copiado para a área de transferência'),
    ));
  }

  Future<void> _shareImage() async {
    try {
      // Generate QR Code image data
      final imageByteData = await QrPainter(
        data: widget.qrCode!.emv!,
        version: QrVersions.auto,
      ).toImageData(150.0);
      final imageBytes = imageByteData!.buffer.asUint8List();

      // Share image directly without saving
      final encodedBytes = base64Encode(imageBytes);
      Share.share(
        'data:image/png;base64,$encodedBytes',
        subject: 'Compartilhar imagem do QR Code',
      );
    } catch (e) {
      print('Erro ao compartilhar imagem: $e');
    }
  }

  Future<void> _saveImageToGallery() async {
    try {
      final imageByteData = await QrPainter(
        data: widget.qrCode!.emv!,
        version: QrVersions.auto,
      ).toImageData(150.0);
      final imageBytes = imageByteData!.buffer.asUint8List();

      final result = await ImageGallerySaver.saveImage(imageBytes);
      if (result != null && result.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Imagem do QR Code salva na galeria'),
        ));
      } else {
        // Handle saving failure gracefully
        print('Erro ao salvar imagem na galeria');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Erro ao salvar imagem na galeria'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Erro ao salvar imagem na galeria'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarDefault(
        title: AppLocalizations.of(context)!.pix_receiver,
        backPage: () =>
            Get.off(() => PixReceive(type: widget.type,), transition: Transition.leftToRight),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: grey120, width: 8),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: QRCodeImage(emvData: widget.qrCode!.emv!),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context)!.pix_codeGenerated,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.pix_dataVisible,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _copyToClipboard(widget.qrCode!.emv.toString());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: grey120,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.pix_copyLink,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _shareImage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: grey120,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.pix_shareCode,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: const Color(0xFFe9eaf0),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                              child: const PixReceive(),
                              type: PageTransitionType.rightToLeft,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.pix_receiveAnother,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                          onPressed: _saveImageToGallery,
                          child: Text(
                            AppLocalizations.of(context)!.pix_saveDevice,
                            style: const TextStyle(color: Colors.black),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class QRCodeImage extends StatelessWidget {
  final String emvData;

  QRCodeImage({required this.emvData});

  @override
  Widget build(BuildContext context) {
    try {
      return QrImageView(
        data: emvData,
        version: QrVersions.auto,
        size: 150.0,
      );
    } catch (e) {
      print("Erro ao gerar o QR Code: $e");
      return const Text("Erro ao gerar o QR Code");
    }
  }
}
