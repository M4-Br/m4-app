import 'dart:io';
import 'dart:ui' as ui;
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/pix/receive/model/pix_create_qr_code_response.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class PixReceiveQrCodeController extends BaseController {
  late PixCreateQrCodeResponse qrCodeData;

  GlobalKey shareQrKey = GlobalKey();

  @override
  void onInit() {
    super.onInit();

    shareQrKey = GlobalKey();

    if (Get.arguments != null && Get.arguments is PixCreateQrCodeResponse) {
      qrCodeData = Get.arguments as PixCreateQrCodeResponse;
    } else {
      ShowToaster.toasterInfo(message: 'QR Code não encontrado');
      Get.back();
    }
  }

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: qrCodeData.emv));
    ShowToaster.toasterInfo(message: 'Copiado para a área de transferência');
  }

  void receiveAnother() {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }
    Get.back();
  }

  Future<Uint8List?> _captureQrImageBytes() async {
    try {
      final RenderRepaintBoundary? boundary = shareQrKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary?;

      if (boundary == null) return null;

      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      return byteData?.buffer.asUint8List();
    } catch (e, s) {
      AppLogger.I().error('Erro ao capturar bytes da imagem', e, s);
      return null;
    }
  }

  Future<void> shareCode() async {
    isLoading(true);
    try {
      final RenderRepaintBoundary? boundary = shareQrKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary?;

      if (boundary == null) {
        throw Exception('Não foi possível renderizar o QR Code.');
      }

      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        throw Exception('Erro ao processar imagem.');
      }

      final Uint8List pngBytes = byteData.buffer.asUint8List();

      final Directory tempDir = await getTemporaryDirectory();
      final String fileName =
          'qrcode_pix_${DateTime.now().millisecondsSinceEpoch}.png';
      final File file = File('${tempDir.path}/$fileName');

      await file.writeAsBytes(pngBytes);

      await Share.shareXFiles([XFile(file.path)],
          text:
              'Segue o QR Code para pagamento PIX.\n\nOu copie e cole o código:\n${qrCodeData.emv}',
          subject: 'QR Code PIX');
    } catch (e, s) {
      AppLogger.I().error('Pix Share QR', e, s);
      ShowToaster.toasterInfo(message: 'Erro ao compartilhar imagem');
    } finally {
      isLoading(false);
    }
  }

  Future<void> saveToGallery() async {
    isLoading(true);
    try {
      if (Platform.isAndroid) {
        var status = await Permission.storage.status;
        if (!status.isGranted) {
          status = await Permission.storage.request();
        }
        if (status.isPermanentlyDenied) {
          ShowToaster.toasterInfo(
              message:
                  'Permissão de galeria negada. Habilite nas configurações.');
          return;
        }
      }

      final Uint8List? pngBytes = await _captureQrImageBytes();

      if (pngBytes == null) {
        throw Exception('Não foi possível gerar a imagem.');
      }

      final String fileName = 'pix_qr_${DateTime.now().millisecondsSinceEpoch}';

      final result = await ImageGallerySaver.saveImage(
        pngBytes,
        quality: 100,
        name: fileName,
      );

      if (result['isSuccess'] == true || result != null) {
        ShowToaster.toasterInfo(
            message: 'QR Code salvo na galeria com sucesso!');
      } else {
        throw Exception('Falha ao salvar arquivo.');
      }
    } catch (e, s) {
      AppLogger.I().error('Pix Save Gallery', e, s);
      ShowToaster.toasterInfo(message: 'Erro ao salvar na galeria');
    } finally {
      isLoading(false);
    }
  }
}
