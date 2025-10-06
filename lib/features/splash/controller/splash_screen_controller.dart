// file: splash_screen_controller.dart

import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<Alignment> positionAnimation;
  late Animation<double> sizeAnimation;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    fadeAnimation =
        Tween<double>(begin: 0.1, end: 1.0).animate(animationController);
    positionAnimation = Tween<Alignment>(
      begin: Alignment.center,
      end: Alignment.topCenter,
    ).animate(animationController);
    sizeAnimation =
        Tween<double>(begin: 0.5, end: 0.5).animate(animationController);

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 300), () {
          Get.offAllNamed(AppRoutes.login);
        });
      }
    });

    animationController.forward();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
