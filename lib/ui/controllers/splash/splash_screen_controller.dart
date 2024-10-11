
import 'package:app_flutter_miban4/ui/screens/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Alignment> _positionAnimation;
  late Animation<double> _sizeAnimation;

  void InitialAnimation(TickerProvider screen) {
    _controller = AnimationController(
      vsync: screen,
      duration: const Duration(milliseconds: 1500),
    );
  }

  void AnimationPosition() {
    _fadeAnimation = Tween<double>(begin: 0.1, end: 1.0).animate(_controller);
    _positionAnimation = Tween<Alignment>(
      begin: Alignment.center,
      end: Alignment.topCenter,
    ).animate(_controller);
    _sizeAnimation = Tween<double>(begin: 0.5, end: 0.5).animate(_controller);
  }

  void AnimationCompleted() {
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.offAll(() => const LoginPage(), transition: Transition.fade);
      }
    });
  }
}