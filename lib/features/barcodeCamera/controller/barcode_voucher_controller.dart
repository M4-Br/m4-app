import 'dart:io';
import 'dart:ui' as ui;
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/strings.dart';
import 'package:app_flutter_miban4/features/barcodeCamera/model/barcode_payment_response.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class BarcodeVoucherController extends BaseController {
  late BarcodePaymentResponse voucherData;
  GlobalKey voucherRepaintKey = GlobalKey();

  @override
  void onInit() {
    voucherRepaintKey = GlobalKey();
    super.onInit();

    final args = Get.arguments;
    if (args != null && args is BarcodePaymentResponse) {
      voucherData = args;
    } else {
      _handleInvalidData();
    }
  }

  void _handleInvalidData() {
    AppLogger.I().error('Barcode Voucher', 'Invalid Args: ${Get.arguments}',
        StackTrace.current);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowToaster.toasterInfo(
          message: 'Erro ao carregar comprovante', isError: true);
      Get.back();
    });
  }

  String get paymentType => voucherData.paymentType.toUpperCase();
  String get status => voucherData.paymentStatus;
  String get transactionId => voucherData.id;

  // --- Ações ---

  void closeVoucher() {
    Get.offAllNamed(AppRoutes.homeView);
  }

  Future<void> shareVoucher() async {
    isLoading(true);
    try {
      final RenderRepaintBoundary? boundary = voucherRepaintKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary?;

      if (boundary == null) throw Exception('Erro de renderização');

      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) throw Exception('Erro de processamento');

      final Uint8List pngBytes = byteData.buffer.asUint8List();
      final Directory tempDir = await getTemporaryDirectory();
      final String fileName =
          'boleto_comprovante_${DateTime.now().millisecondsSinceEpoch}.png';
      final File file = File('${tempDir.path}/$fileName');

      await file.writeAsBytes(pngBytes);

      await Share.shareXFiles(
        [XFile(file.path)],
        text:
            'Comprovante de pagamento de boleto - Valor: ${voucherData.amount.toBRL()}',
      );
    } catch (e, s) {
      AppLogger.I().error('Share Voucher', e, s);
      ShowToaster.toasterInfo(message: 'Erro ao compartilhar', isError: true);
    } finally {
      isLoading(false);
    }
  }
}
