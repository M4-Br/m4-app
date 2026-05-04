import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/features/ai/presentation/ai_manager_page.dart';
import 'package:app_flutter_miban4/features/digitalAccount/presentation/digital_account_page.dart';
import 'package:app_flutter_miban4/features/home/controller/home_controller.dart';
import 'package:app_flutter_miban4/features/home/presentation/home_page.dart';
import 'package:app_flutter_miban4/features/profile/presentation/profile_page.dart';
import 'package:app_flutter_miban4/features/documents/presentation/documents_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewPage extends GetView<HomeViewController> {
  const HomeViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      HomePage(),
      DigitalAccountPage(),
      AiManagerPage(),
      const DocumentsPage(), // 3: Documentos
      const ProfilePage(), // 4: Perfil
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
                label: 'IA',
              ),
              BottomNavigationBarItem(
                icon: controller.getIconForIndex(3),
                label: 'Documentos',
              ),
              BottomNavigationBarItem(
                icon: controller.getIconForIndex(4),
                label: 'Perfil',
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
