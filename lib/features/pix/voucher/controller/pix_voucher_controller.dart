import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/strings.dart';
import 'package:app_flutter_miban4/features/pix/transfer/model/pix_transfer_response.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class PixVoucherController extends BaseController {
  late PixTransferResponse voucherData;

  GlobalKey voucherRepaintKey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
    voucherRepaintKey = GlobalKey();

    if (Get.arguments != null && Get.arguments is PixTransferResponse) {
      voucherData = Get.arguments as PixTransferResponse;
    } else {
      _handleInvalidData();
    }
  }

  void _handleInvalidData() {
    AppLogger.I().error('Pix Voucher', 'Dados inválidos ou nulos no argumento',
        StackTrace.current);

    voucherData = PixTransferResponse(
      amount: '0',
      receiverName: 'Desconhecido',
      bankName: 'Não informado',
      transactionDate: DateTime.now().toIso8601String(),
      success: true,
    );

    ShowToaster.toasterInfo(
        message: 'Não foi possível carregar todos os detalhes do comprovante.',
        isError: true);
  }

  String get formattedDate => voucherData.transactionDate.toVoucherFormat();

  String get formattedAmount {
    try {
      final value = double.parse(voucherData.amount) / 100;
      return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
          .format(value);
    } catch (e) {
      return 'R\$ 0,00';
    }
  }

  String get receiverName => voucherData.receiverName;
  String get bankName => voucherData.bankName;
  String get payerName => userRx.user.value?.payload.fullName ?? 'Usuário';

  // --- Ações ---

  void closeVoucher() {
    Get.offNamedUntil(AppRoutes.pixHome,
        (route) => route.settings.name == AppRoutes.homeView);
  }

  Future<void> shareVoucher() async {
    isLoading(true);
    try {
      final RenderRepaintBoundary? boundary = voucherRepaintKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary?;

      if (boundary == null) {
        throw Exception('Não foi possível renderizar o comprovante.');
      }

      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) throw Exception('Erro ao processar imagem.');

      final Uint8List pngBytes = byteData.buffer.asUint8List();
      final Directory tempDir = await getTemporaryDirectory();
      final String fileName =
          'comprovante_pix_${DateTime.now().millisecondsSinceEpoch}.png';
      final File file = File('${tempDir.path}/$fileName');

      await file.writeAsBytes(pngBytes);

      await Share.shareXFiles([XFile(file.path)],
          text:
              'Comprovante de transferência Pix para $receiverName - Valor: $formattedAmount',
          subject: 'Comprovante Pix');
    } catch (e, s) {
      AppLogger.I().error('Share Voucher', e, s);
      ShowToaster.toasterInfo(
          message: 'Erro ao compartilhar comprovante', isError: true);
    } finally {
      isLoading(false);
    }
  }
}
