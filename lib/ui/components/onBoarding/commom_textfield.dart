import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget commonTextField(TextEditingController controller, String labelName, TextInputType textInputType, String prefixText, TextInputFormatter formatter, Function(String)? function) {
  return Padding(
    padding: const EdgeInsets.only(top: 16),
    child: TextField(
      cursorColor: secondaryColor,
      onChanged: function != null ? (newText) => function(newText) : null,
      controller: controller,
      keyboardType: textInputType,
      style: const TextStyle(color: Colors.black),
      inputFormatters: [formatter],
      decoration: InputDecoration(
        prefixText: prefixText,
        isDense: true,
        border: InputBorder.none,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.deepOrange),
        ),
        contentPadding: EdgeInsets.zero,
        labelText: labelName,
        labelStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
        hintText: '',
      ),
    ),
  );
}