import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:flutter/material.dart';

class PrivacyCurtain extends StatelessWidget {
  const PrivacyCurtain({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            gapXL,
            Image.asset('assets/images/m4_ic_logo.png'),
          ],
        ),
      ),
    );
  }
}
