import 'dart:async';
import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
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
    if (isLoading) {
      return SizedBox(
        height: 50,
        child: Center(
          child: AppLoading(
            color: color ?? secondaryColor,
          ),
        ),
      );
    }

    final Widget label = _label();
    const double minHeight = 50.0;
    final BorderRadius borderRadius = BorderRadius.circular(12);

    return switch (buttonType) {
      // --- FILLED ---
      AppButtonType.filled => icon != null
          ? FilledButton.icon(
              onPressed: onPressed,
              label: label,
              icon: icon!,
              style: FilledButton.styleFrom(
                backgroundColor: color ?? secondaryColor,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, minHeight),
                shape: RoundedRectangleBorder(borderRadius: borderRadius),
              ),
            )
          : FilledButton(
              onPressed: onPressed,
              style: FilledButton.styleFrom(
                backgroundColor: color ?? secondaryColor,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, minHeight),
                shape: RoundedRectangleBorder(borderRadius: borderRadius),
              ),
              child: label,
            ),

      // --- ELEVATED ---
      AppButtonType.elevated => icon != null
          ? ElevatedButton.icon(
              onPressed: onPressed,
              label: label,
              icon: icon!,
              style: ElevatedButton.styleFrom(
                backgroundColor: color ?? secondaryColor,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, minHeight),
              ),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: color ?? secondaryColor,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, minHeight),
              ),
              child: label,
            ),

      // --- OUTLINED ---
      AppButtonType.outlined => icon != null
          ? OutlinedButton.icon(
              onPressed: onPressed,
              label: label,
              icon: icon!,
              style: OutlinedButton.styleFrom(
                foregroundColor: color ?? secondaryColor,
                side: BorderSide(color: color ?? Colors.grey),
                backgroundColor: Colors.transparent,
                minimumSize: const Size(double.infinity, minHeight),
              ),
            )
          : OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: color ?? secondaryColor,
                side: BorderSide(color: color ?? Colors.grey),
                backgroundColor: Colors.transparent,
                minimumSize: const Size(double.infinity, minHeight),
              ),
              child: label,
            ),

      // --- TEXT ---
      AppButtonType.text => icon != null
          ? TextButton.icon(
              onPressed: onPressed,
              label: label,
              icon: icon!,
              style: TextButton.styleFrom(
                foregroundColor: color,
                alignment: Alignment.center,
                textStyle: const TextStyle(fontSize: 16),
              ),
            )
          : TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(
                foregroundColor: color,
                alignment: Alignment.center,
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: label,
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
