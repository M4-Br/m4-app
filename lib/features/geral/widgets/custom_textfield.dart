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
  bool? obscureText,
  VoidCallback? onTogglePassword,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    validator: validator,
    maxLength: maxLength,
    inputFormatters: formatters,
    obscureText: obscureText ?? false,

    // --- A MÁGICA CONTRA O BUG DO CURSOR AQUI ---
    onTap: () {
      // Se o Flutter criar uma seleção (onde o início é diferente do fim)
      if (controller.selection.baseOffset !=
          controller.selection.extentOffset) {
        // Forçamos o cursor a ficar exatamente onde o dedo do usuário tocou
        controller.selection = TextSelection.collapsed(
          offset: controller.selection.extentOffset,
        );
      }
    },
    // --------------------------------------------

    decoration: InputDecoration(
      suffixIcon: obscureText != null
          ? IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: onTogglePassword,
            )
          : null,
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
