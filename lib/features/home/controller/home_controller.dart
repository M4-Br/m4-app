import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewController extends GetxController {
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _setInitialIndexFromRoute(Get.currentRoute);
  }

  void _setInitialIndexFromRoute(String route) {
    switch (route) {
      case AppRoutes.plans:
        selectedIndex.value = 1;
        break;
      case AppRoutes.profile:
        selectedIndex.value = 2;
        break;
      default:
        selectedIndex.value = 0;
    }
  }

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  Widget getIconForIndex(int index) {
    final Color color =
        selectedIndex.value == index ? secondaryColor : Colors.grey;

    switch (index) {
      case 0: // Home
        return Image.asset('assets/icons/ic_home.png', width: 30, color: color);
      case 1: // Statement
        return Image.asset('assets/icons/ic_plans.png',
            width: 30, color: color);
      case 2: // Perfil
        return Image.asset('assets/icons/ic_config.png',
            width: 30, color: color);
      default:
        return Image.asset('assets/icons/ic_home.png', width: 30, color: color);
    }
  }
}
