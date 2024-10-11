import 'package:flutter/services.dart';

class BarcodeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final cleanText = newValue.text.replaceAll(RegExp(r'[^0-9]'), ''); // Remove todos os caracteres não numéricos
    final formattedText = _formatBarcode(cleanText);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String _formatBarcode(String text) {
    final formattedParts = <String>[];
    final groupSize = 12;

    for (int i = 0; i < text.length; i += groupSize) {
      final part = text.substring(i, i + groupSize);
      formattedParts.add(part);
    }

    return formattedParts.join(' '); // Adiciona espaço entre cada grupo de 12 dígitos
  }
}