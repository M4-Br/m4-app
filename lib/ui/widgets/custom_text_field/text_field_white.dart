import 'package:app_flutter_miban4/domain/helpers/mask_shifter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldWhite extends StatefulWidget {
  final bool hasMask;
  final String label;
  final TextEditingController controller;

  const TextFieldWhite(
      {super.key,
        required this.hasMask,
        required this.label,
        required this.controller,
      });

  @override
  State<TextFieldWhite> createState() => _TextFieldWhiteState();
}

class _TextFieldWhiteState extends State<TextFieldWhite> {
  Rx _obscure = false.obs;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: const TextStyle(color: Colors.white, fontSize: 18),
      keyboardType: const TextInputType.numberWithOptions(),
      inputFormatters: widget.hasMask ? [MaskShifter.idFormatter] : null,
      maxLength: widget.hasMask ? null : 6,
      obscureText: widget.hasMask ? false : !_obscure.value,
      decoration: InputDecoration(
        floatingLabelStyle: const TextStyle(color: Colors.white),
        counterStyle: const TextStyle(color: Colors.transparent),
        suffixIcon: widget.hasMask
            ? null
            : IconButton(
          onPressed: () {
            setState(() {
              _obscure.value = !_obscure.value;
            });
          },
          icon: Obx(
                () => _obscure.value
                ? const Icon(
              Icons.visibility,
              color: Colors.white,
            )
                : const Icon(
              Icons.visibility_off,
              color: Colors.white,
            ),
          ),
        ),
        labelText: widget.label,
        labelStyle: const TextStyle(color: Colors.white),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}