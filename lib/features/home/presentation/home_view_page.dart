import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/features/digitalAccount/presentation/digital_account_page.dart';
import 'package:app_flutter_miban4/features/home/controller/home_controller.dart';
import 'package:app_flutter_miban4/features/home/presentation/home_page.dart';
import 'package:app_flutter_miban4/features/marketplace/presentation/marketplace_page.dart';
import 'package:app_flutter_miban4/features/profile/presentation/profile_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewPage extends GetView<HomeViewController> {
  const HomeViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      HomePage(),
      DigitalAccountPage(),
      MarketplacePage(),
      const Scaffold(
          body: Center(child: Text('Página: Pedidos'))), // 3: Pedidos
      const Scaffold(body: Center(child: Text('Página: Saúde'))), // 4: Saúde
      const ProfilePage(), // 5: Perfil
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => IndexedStack(
            index: controller.selectedIndex.value,
            children: widgetOptions,
          )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            type: BottomNavigationBarType
                .fixed, // Essencial para mostrar mais de 3 itens
            backgroundColor: Colors.white,
            selectedItemColor: secondaryColor,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            // Dica: diminuir a fonte pode ajudar a encaixar melhor os 6 itens lado a lado
            selectedFontSize: 11,
            unselectedFontSize: 11,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: controller.getIconForIndex(0),
                label:
                    'Início', // ou 'home_icon'.tr se preferir manter o padrão
              ),
              BottomNavigationBarItem(
                icon: controller.getIconForIndex(1),
                label: 'Carteira',
              ),
              BottomNavigationBarItem(
                icon: controller.getIconForIndex(2),
                label: 'Loja',
              ),
              BottomNavigationBarItem(
                icon: controller.getIconForIndex(3),
                label: 'Pedidos',
              ),
              BottomNavigationBarItem(
                icon: controller.getIconForIndex(4),
                label: 'Saúde',
              ),
              BottomNavigationBarItem(
                icon: controller.getIconForIndex(5),
                label: 'Perfil', // ou 'perfil_icon'.tr
              ),
            ],
            currentIndex: controller.selectedIndex.value,
            onTap: (index) {
              controller.onItemTapped(index);
            },
          )),
    );
  }
}
