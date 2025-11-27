import 'package:app_flutter_miban4/features/splash/controller/splash_screen_controller.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashScreenController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 55),
        child: AnimatedBuilder(
          animation: controller.animationController,
          builder: (context, child) {
            return Align(
              alignment: controller.positionAnimation.value,
              child: Opacity(
                opacity: controller.fadeAnimation.value,
                child: Transform.scale(
                  scale: controller.sizeAnimation.value,
                  child: Image.asset('assets/images/ic_default_logo.png'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
