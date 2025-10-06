import 'dart:async';
import 'package:app_flutter_miban4/core/helpers/utils/app_loading.dart';
import 'package:flutter/material.dart';

enum AppButtonType { filled, elevated, outlined, text }

class AppButton extends StatelessWidget {
  const AppButton({
    required this.onPressed,
    this.isLoading = false,
    this.labelText,
    this.buttonType = AppButtonType.filled,
    this.child,
    this.icon,
    this.color,
    super.key,
  }) : assert(
          (child == null && labelText != null) ||
              (child != null && labelText == null),
          'Must have either a label text for Text or a child, not both',
        );

  final bool isLoading;
  final Future<void> Function()? onPressed;
  final String? labelText;
  final Widget? child;
  final Widget? icon;
  final Color? color;
  final AppButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    final Future<void> Function()? action;
    final Widget? icon;

    if (isLoading) {
      action = null;
      icon = AppLoading(color: color,);
    } else {
      action = onPressed;
      icon = this.icon;
    }

    final Widget label = _label();

    return switch (buttonType) {
      AppButtonType.filled => FilledButton.icon(
          onPressed: action,
          label: label,
          icon: icon,
          style: FilledButton.styleFrom(
              backgroundColor: color,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0))),
        ),
      AppButtonType.elevated => ElevatedButton.icon(
          onPressed: action,
          label: label,
          icon: icon,
          style: ElevatedButton.styleFrom(
              backgroundColor: color,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50)),
        ),
      AppButtonType.outlined => OutlinedButton.icon(
          onPressed: action,
          label: label,
          icon: icon,
          style: OutlinedButton.styleFrom(
              foregroundColor: color,
              side: BorderSide(color: color ?? Colors.grey),
              backgroundColor: Colors.transparent,
              minimumSize: const Size(double.infinity, 50)),
        ),
      AppButtonType.text => TextButton.icon(
          onPressed: action,
          label: label,
          icon: icon,
          style: TextButton.styleFrom(
            foregroundColor: color,
            alignment: Alignment.center,
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
    };
  }

  Widget _label() {
    final String? labelText = this.labelText;

    if (labelText != null) {
      return Text(labelText);
    }
    return child ?? const SizedBox();
  }
}
