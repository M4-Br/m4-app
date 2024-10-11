import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckboxCustom extends StatefulWidget {
  final String title;
  final String subtitle;
  bool value;
  final bool read;
  final Function(bool?) onChanged;

  CheckboxCustom({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.read,
    required this.onChanged,
  });

  @override
  State<CheckboxCustom> createState() => _CheckboxCustomState();
}

class _CheckboxCustomState extends State<CheckboxCustom> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.title),
      subtitle: Text(widget.subtitle),
      value: widget.value,
      onChanged: widget.read
          ? null
          : (newValue) {
        setState(() {
          widget.value = newValue!;
        });
        widget.onChanged(newValue);
      },
      controlAffinity: ListTileControlAffinity.leading,
      tristate: true,
      checkColor: Colors.white,
      activeColor: secondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Get.theme.colorScheme.surface),
      ),
    );
  }
}