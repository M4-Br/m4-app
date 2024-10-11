import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(
          text: '0,00', selection: const TextSelection.collapsed(offset: 6));
    }

    final double amount = double.parse(newValue.text) / 100;

    final NumberFormat formatter = NumberFormat.currency(
        locale: 'pt_BR', symbol: 'R\$', decimalDigits: 2);

    final String newText = formatter.format(amount);
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}