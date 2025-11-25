import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:flutter/material.dart';

Widget bottomButton({
  required VoidCallback onPressed,
  required String labelText,
  required bool isLoading,
}) {
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
      ),
    ),
  );
}
