import 'package:app_flutter_miban4/ui/colors/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final bool userTheme;
  final TextEditingController controller;
  final TextInputType inputType;
  final Color? color;
  final TextInputFormatter formatter;
  final String Function(String?)? validator;
  final String textLabel;

  const CustomTextField(
      {super.key,
      required this.userTheme,
      required this.controller,
      required this.inputType,
      this.color,
      required this.formatter,
      this.validator,
      required this.textLabel});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: widget.userTheme == true
          ? Theme.of(context).colorScheme.secondary
          : widget.color,
      controller: widget.controller,
      keyboardType: widget.inputType,
      style: TextStyle(
          color: widget.userTheme == true
              ? Theme.of(context).colorScheme.tertiary
              : widget.color,
          fontSize: 20),
      inputFormatters: [widget.formatter],
      validator: widget.validator,
      decoration: InputDecoration(
        isDense: true,
        border: InputBorder.none,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: widget.userTheme == true
                  ? Theme.of(context).colorScheme.tertiary
                  : widget.color!),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: widget.userTheme == true
                  ? secondaryColor
                  : widget.color!),
        ),
        contentPadding: EdgeInsets.zero,
        labelText: widget.textLabel,
        labelStyle: TextStyle(
          color: widget.userTheme == true
              ? Theme.of(context).colorScheme.tertiary
              : widget.color!,
          fontSize: 16,
        ),
        hintText: '',
      ),
    );
  }
}
