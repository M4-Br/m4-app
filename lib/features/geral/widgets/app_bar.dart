import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? iconColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.onBackPressed,
    this.actions,
    this.backgroundColor,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    const Color defaultPrimaryColor = Colors.blue;

    return AppBar(
      title: AppText.titleMedium(context, title, color: Colors.white),
      centerTitle: true,
      backgroundColor: backgroundColor ?? defaultPrimaryColor,
      elevation: 0,
      actions: actions,
      leading: showBackButton
          ? IconButton(
              onPressed: onBackPressed ?? () => Get.back(),
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: iconColor,
              ),
            )
          : null,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
