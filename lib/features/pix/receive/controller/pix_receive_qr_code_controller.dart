import 'dart:io';
import 'dart:ui' as ui;
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/pix/receive/model/pix_create_qr_code_response.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gal/gal.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class PixReceiveQrCodeController extends BaseController {
  late PixCreateQrCodeResponse qrCodeData;

  GlobalKey shareQrKey = GlobalKey();

  @override
  void onInit() {
    shareQrKey = GlobalKey();
    super.onInit();

    if (Get.arguments != null && Get.arguments is PixCreateQrCodeResponse) {
      qrCodeData = Get.arguments as PixCreateQrCodeResponse;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ShowToaster.toasterInfo(
            message: 'QR Code não encontrado', isError: true);
        Get.back();
      });
    }
  }

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: qrCodeData.emv));
    ShowToaster.toasterInfo(message: 'Copiado para a área de transferência');
  }

  void backUntil() {
    Get.until((route) => route.settings.name == AppRoutes.pixHome);
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
      final Uint8List? pngBytes = await _captureQrImageBytes();

      if (pngBytes == null) {
        throw Exception('Não foi possível renderizar o QR Code.');
      }

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
      ShowToaster.toasterInfo(
          message: 'Erro ao compartilhar imagem', isError: true);
    } finally {
      isLoading(false);
    }
  }

  Future<void> saveToGallery() async {
    isLoading(true);
    try {
      final Uint8List? pngBytes = await _captureQrImageBytes();

      if (pngBytes == null) {
        throw Exception('Não foi possível gerar a imagem.');
      }

      await Gal.putImageBytes(
        pngBytes,
        name: 'pix_qr_${DateTime.now().millisecondsSinceEpoch}',
      );

      ShowToaster.toasterInfo(message: 'QR Code salvo na galeria com sucesso!');
    } on GalException catch (e) {
      if (e.type == GalExceptionType.accessDenied) {
        ShowToaster.toasterInfo(
            message: 'Permissão de galeria negada.', isError: true);
      } else {
        ShowToaster.toasterInfo(message: 'Erro ao salvar: $e', isError: true);
      }
    } catch (e, s) {
      AppLogger.I().error('Pix Save Gallery', e, s);
      ShowToaster.toasterInfo(
          message: 'Erro ao salvar na galeria', isError: true);
    } finally {
      isLoading(false);
    }
  }
}
