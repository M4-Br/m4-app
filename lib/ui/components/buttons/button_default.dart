import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final Function() function;
  final Color buttonColor;
  final Color textColor;
  final String buttonName;

  const DefaultButton(
      {super.key,
      required this.function,
      required this.buttonColor,
      required this.textColor,
      required this.buttonName});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            buttonName,
            style: TextStyle(
                color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
