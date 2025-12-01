import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:flutter/material.dart';

Widget bottomButton(
    {required VoidCallback onPressed,
    required String labelText,
    required bool isLoading,
    required bool enable}) {
  return Padding(
    padding: const EdgeInsets.only(
      bottom: AppDimens.kPaddingXXL,
    ),
    child: SizedBox(
      width: double.infinity,
      height: 56,
      child: AppButton(
        isLoading: isLoading,
        onPressed: () async => onPressed(),
        labelText: labelText,
        buttonType: AppButtonType.filled,
        color: enable ? secondaryColor : Colors.grey,
      ),
    ),
  );
}
