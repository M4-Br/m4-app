import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:flutter/material.dart';

class AppBarDefault extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconButton? rightIcon;
  final Function()? backPage;
  final bool? hasIcon;

  const AppBarDefault({
    super.key,
    required this.title,
    this.rightIcon,
    this.backPage,
    this.hasIcon = true
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SafeArea(
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: primaryColor,
      leading: hasIcon == true ? SafeArea(
        child: IconButton(
          onPressed: backPage,
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
        ),
      ) : null,
      actions:
          rightIcon != null ? [SafeArea(child: rightIcon!)] : null,
      automaticallyImplyLeading: false,
    );
  }
}
