import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 50,
      child: CircularProgressIndicator(
        strokeWidth: 1.5,
        color: color ?? secondaryColor,
      ),
    );
  }
}
