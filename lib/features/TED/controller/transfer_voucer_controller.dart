import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/TED/model/transfer_voucher_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class TransferVoucherController extends BaseController {
  late TransferVoucher voucher;

  final GlobalKey voucherRepaintKey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is TransferVoucher) {
      voucher = args;
    } else {
      Get.back();
    }
  }

  String get transactionId =>
      voucher.transactionCode ?? voucher.transactionId ?? '-';

  String get receiverName => voucher.receiver?.receiverFullName ?? '-';
  String get receiverDoc =>
      _formatCPF(voucher.receiver?.receiverDocument ?? '');
  String get receiverBank => voucher.receiver?.receiverBank ?? 'Miban4';

  String get payerName => voucher.payer?.payerFullName ?? '-';
  String get payerDoc => _formatCPF(voucher.payer?.payerDocument ?? '');

  String _formatCPF(String cpf) {
    if (cpf.length < 11) return cpf;
    return '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-${cpf.substring(9)}';
  }

  void closeVoucher() {
    Get.until((route) => route.settings.name == AppRoutes.homeView);
  }

  Future<void> shareVoucher() async {
    isLoading(true);
    try {
      RenderRepaintBoundary? boundary = voucherRepaintKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary?;

      if (boundary == null) return;

      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        final Uint8List pngBytes = byteData.buffer.asUint8List();

        final directory = await getTemporaryDirectory();
        final File imgFile =
            File('${directory.path}/comprovante_transferencia.png');
        await imgFile.writeAsBytes(pngBytes);

        await Share.shareXFiles(
          [XFile(imgFile.path)],
          text: 'Comprovante de Transferência M4',
        );
      }
    } catch (e) {
      AppLogger.I().info('Erro ao compartilhar: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }
}
