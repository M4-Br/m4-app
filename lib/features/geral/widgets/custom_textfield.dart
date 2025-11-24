import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget buildCustomInput({
  required String label,
  required String hint,
  required TextEditingController controller,
  List<TextInputFormatter>? formatters,
  TextInputType keyboardType = TextInputType.text,
  String? Function(String?)? validator,
  int? maxLength,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    validator: validator,
    maxLength: maxLength,
    inputFormatters: formatters,
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
      contentPadding: const EdgeInsets.symmetric(vertical: 12),
      border: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black87, width: 1.5),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
    ),
  );
}
