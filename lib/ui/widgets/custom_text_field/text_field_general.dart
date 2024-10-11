import 'package:app_flutter_miban4/domain/helpers/mask_shifter.dart';
import 'package:flutter/material.dart';

class TextFieldGeneral extends StatefulWidget {
  final bool hasMask;
  final String label;
  final TextEditingController controller;
  final TextInputType keyboard;
  final bool hasLimit;
  final String? Function(String?)? validator;
  final int? limit;

  const TextFieldGeneral({super.key,
    required this.hasMask,
    required this.label,
    required this.controller,
    required this.keyboard,
    required this.hasLimit,
    required this.validator,
    this.limit});

  @override
  State<TextFieldGeneral> createState() => _TextFieldGeneralState();
}

class _TextFieldGeneralState extends State<TextFieldGeneral> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: const TextStyle(fontSize: 18),
      keyboardType: widget.keyboard,
      validator: widget.validator,
      maxLength: widget.hasLimit ? widget.limit! : null,
      inputFormatters: widget.hasMask ? [MaskShifter.idFormatter] : null,
      decoration: InputDecoration(
          labelText: widget.label,
          counterStyle: const TextStyle(color: Colors.transparent)
      ),
    );
  }
}
