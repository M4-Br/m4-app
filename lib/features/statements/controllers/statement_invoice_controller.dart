// lib/features/statements/controllers/statement_invoice_controller.dart

import 'dart:io';
import 'dart:ui' as ui; // Importa 'ui' como alias
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/statements/model/statement_invoice_response.dart';
import 'package:app_flutter_miban4/features/statements/repository/statement_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/strings.dart';

class StatementInvoiceController extends BaseController {
  final Rx<StatementInvoice?> invoice = Rx<StatementInvoice?>(null);

  @override
  void onInit() {
    super.onInit();
    final String? statementId = Get.parameters['id'];

    if (statementId != null) {
      fetchInvoiceDetails(statementId);
    } else {
      isLoading.value = false;
    }
  }

  Future<void> fetchInvoiceDetails(String statementId) async {
    await executeSafe(() async {
      final result =
          await StatementRepository().fetchInvoice(statementId: statementId);
      invoice.value = result;
    });
  }

  void shareInvoiceAsText() {
    final currentInvoice = invoice.value;
    if (currentInvoice == null) {
      Get.snackbar('Erro', 'Não há dados no comprovante para compartilhar.');
      return;
    }
    final String shareableText = _generateShareableText(currentInvoice);
    Share.share(shareableText, subject: 'Comprovante de Transferência');
  }

  String _generateShareableText(StatementInvoice invoice) {
    final buffer = StringBuffer();
    buffer.writeln('🧾 *Comprovante de Transferência* 🧾');
    buffer.writeln('------------------------------------');
    buffer.writeln('*Valor:* ${invoice.amount.toBRL()}');
    buffer.writeln('*Data:* ${invoice.date}');
    buffer.writeln('*Tipo:* ${invoice.type.capitalizeFirst ?? invoice.type}');
    buffer.writeln('------------------------------------');
    buffer.writeln('*Quem Pagou:*');
    buffer.writeln('Nome: ${invoice.payer.name}');
    buffer.writeln('CPF/CNPJ: ${invoice.payer.document}');
    buffer.writeln('------------------------------------');
    buffer.writeln('*Quem Recebeu:*');
    buffer.writeln('Nome: ${invoice.receiver.name}');
    buffer.writeln('CPF/CNPJ: ${invoice.receiver.document}');
    buffer.writeln('------------------------------------');
    buffer.writeln('*Autenticação:*');
    buffer.writeln(invoice.authentication);

    return buffer.toString();
  }

  Future<void> shareInvoiceAsImage(
      GlobalKey repaintBoundaryKey, StatementInvoice invoice) async {
    isLoading(true);
    try {
      final RenderRepaintBoundary? boundary = repaintBoundaryKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary?;

      if (boundary == null) {
        throw Exception(
            'Não foi possível encontrar a fronteira de renderização.');
      }

      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        throw Exception('Não foi possível converter a imagem para ByteData.');
      }

      final Uint8List pngBytes = byteData.buffer.asUint8List();

      final Directory tempDir = await getTemporaryDirectory();
      final File file = File('${tempDir.path}/comprovante_${invoice.id}.png');
      await file.writeAsBytes(pngBytes);

      await Share.shareXFiles([XFile(file.path)],
          subject: 'Comprovante de Transferência');

      await file.delete();
    } catch (e, s) {
      Get.snackbar('Erro ao compartilhar',
          'Não foi possível gerar ou compartilhar o comprovante como imagem: $e');
      AppLogger.I().error('App Share Invoice', e, s);
    } finally {
      isLoading(false);
    }
  }
}
