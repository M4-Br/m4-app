import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MaskUtil {
  static String applyMask(String value, String mask) {
    final result = StringBuffer();
    var valueIndex = value.length - 1;

    for (var i = mask.length - 1; i >= 0; i--) {
      if (valueIndex < 0) {
        break;
      }

      if (mask[i] == '#') {
        result.write(value[valueIndex]);
        valueIndex--;
      } else {
        result.write(mask[i]);
      }
    }

    return result.toString().split('').reversed.join();
  }
}

class SmartPixMaskFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    if (text.contains(RegExp(r'[a-zA-Z@]'))) {
      return newValue;
    }

    final digits = text.replaceAll(RegExp(r'[^0-9]'), '');
    String formatted = '';

    if (digits.length > 11) {
      for (int i = 0; i < digits.length; i++) {
        if (i == 2 || i == 5) formatted += '.';
        if (i == 8) formatted += '/';
        if (i == 12) formatted += '-';
        formatted += digits[i];
      }
    } else if (digits.length == 11) {
      if (GetUtils.isCpf(digits)) {
        for (int i = 0; i < digits.length; i++) {
          if (i == 3 || i == 6) formatted += '.';
          if (i == 9) formatted += '-';
          formatted += digits[i];
        }
      } else {
        formatted =
            '(${digits.substring(0, 2)}) ${digits.substring(2, 7)}-${digits.substring(7)}';
      }
    } else {
      for (int i = 0; i < digits.length; i++) {
        if (i == 3 || i == 6) formatted += '.';
        if (i == 9) formatted += '-';
        formatted += digits[i];
      }
    }
    if (formatted.length > 18) {
      formatted = formatted.substring(0, 18);
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
