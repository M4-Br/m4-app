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
      case AppRoutes.profile:
        selectedIndex.value = 5;
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
      case 0: // Início
        return Icon(Icons.home_outlined, size: 28, color: color);
      case 1: // Carteira Digital
        return Icon(Icons.account_balance_wallet_outlined,
            size: 28, color: color);
      case 2: // Loja (Marketplace)
        return Icon(Icons.storefront_outlined, size: 28, color: color);
      case 3: // Pedidos (Ícone de caixa)
        return Icon(Icons.inventory_2_outlined, size: 28, color: color);
      case 4: // Perfil
        return Icon(Icons.person_outline, size: 28, color: color);
      default:
        return Icon(Icons.home_outlined, size: 28, color: color);
    }
  }
}
