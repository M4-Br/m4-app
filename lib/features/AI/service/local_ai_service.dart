import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';

class LocalAiService {
  static Map<String, dynamic> processUserIntent(String text) {
    final input = text.toLowerCase().trim();
    final hasPixKey = input.contains('pix') &&
        input.contains(RegExp(r'(chave|chaves|meus|minhas|cadastrados)'));
    final hasBoleto = input.contains(RegExp(r'(boleto|conta|fatura|pagar)'));
    final hasQrCode = input.contains(RegExp(r'(qrcode|code)'));

    if (hasPixKey) {
      return {
        'type': 'NAVIGATION',
        'target': AppRoutes.pixKeyManager,
        'message': 'Abrindo suas chaves Pix...'
      };
    }
    if (hasBoleto) {
      return {
        'type': 'NAVIGATION',
        'target': AppRoutes.barcode,
        'message': 'Abrindo câmera para boleto...'
      };
    }
    if (hasQrCode) {
      return {
        'type': 'NAVIGATION',
        'target': AppRoutes.pixQrCodeReader,
        'message': 'Leitor de QR Code...'
      };
    }

    final isTransferIntent =
        input.contains(RegExp(r'(pix|mandar|transferir|envia|fazer)')) &&
            input.contains(RegExp(r'\d'));

    if (isTransferIntent) {
      final data = _extractTransferData(input);
      if (data['type'] != 'UNKNOWN') {
        return data;
      }
    }

    return {
      'type': 'UNKNOWN',
      'message':
          'Desculpe, não entendi. Tente "Pix 50 para João" ou "Meus Pix".'
    };
  }

  static Map<String, dynamic> _extractTransferData(String input) {
    String cleanInput = input;
    String? amount;

    final naturalMoneyMatch = RegExp(
            r'(\d+)\s*(?:reais|real)(?:\s*e\s*(\d+)\s*(?:centavos|centavo))?')
        .firstMatch(cleanInput);

    if (naturalMoneyMatch != null) {
      final reais = naturalMoneyMatch.group(1) ?? '0';
      final centavos = naturalMoneyMatch.group(2) ?? '00';
      amount = '$reais.${centavos.padLeft(2, '0')}';
      cleanInput = cleanInput.replaceFirst(naturalMoneyMatch.group(0)!, '');
    } else {
      final simpleNumberMatch =
          RegExp(r'\b\d+([.,]\d{1,2})?\b').firstMatch(cleanInput);
      if (simpleNumberMatch != null) {
        amount = simpleNumberMatch.group(0);
        cleanInput = cleanInput.replaceFirst(simpleNumberMatch.group(0)!, '');
      }
    }

    cleanInput = cleanInput.replaceAll(
        RegExp(r'(pix|mandar|transferir|envia|fazer|valor|de)'), '');
    cleanInput = cleanInput.replaceAll(RegExp(r'(para|pro|pra|ao|a )'), '');
    cleanInput = cleanInput.replaceAll(RegExp(r'(centavos|centavo)'), '');
    String name = cleanInput.replaceAll(RegExp(r'[.,]'), '').trim();

    if (name.isNotEmpty) {
      return {
        'type': 'TRANSFER_ATTEMPT',
        'name': name,
        'amount': amount,
        'message': 'Procurando $name...'
      };
    }

    return {
      'type': 'UNKNOWN',
      'message': 'Entendi o valor, mas não entendi para quem é.'
    };
  }
}
