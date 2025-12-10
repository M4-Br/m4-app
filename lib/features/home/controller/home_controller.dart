import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewController extends GetxController {
  var selectedIndex = 0.obs;

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
        return Image.asset('assets/icons/ic_statement2.png',
            width: 30, color: color);
      case 2: // Perfil
        return Image.asset('assets/icons/ic_config.png',
            width: 30, color: color);
      default: // Ícone padrão para segurança
        return Image.asset('assets/icons/ic_home.png', width: 30, color: color);
    }
  }
}
