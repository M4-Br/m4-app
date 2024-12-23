import 'package:app_flutter_miban4/ui/screens/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  late AnimationController controller;
  late Animation<double> fadeAnimation;
  late Animation<Alignment> positionAnimation;
  late Animation<double> sizeAnimation;

  void InitialAnimation(TickerProvider screen) {
    controller = AnimationController(
      vsync: screen,
      duration: const Duration(milliseconds: 1500),
    );
  }

  void AnimationPosition() {
    fadeAnimation = Tween<double>(begin: 0.1, end: 1.0).animate(controller);
    positionAnimation = Tween<Alignment>(
      begin: Alignment.center,
      end: Alignment.topCenter,
    ).animate(controller);
    sizeAnimation = Tween<double>(begin: 0.5, end: 0.5).animate(controller);
  }

  void AnimationCompleted() {
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.offAll(() => const LoginPage(), transition: Transition.fade);
      }
    });
  }
}
