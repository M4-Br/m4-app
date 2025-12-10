import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/features/home/controller/home_controller.dart';
import 'package:app_flutter_miban4/features/home/presentation/home_page.dart';
import 'package:app_flutter_miban4/features/profile/presentation/profile_page.dart';

import 'package:app_flutter_miban4/features/statements/presentation/statement_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewPage extends GetView<HomeViewController> {
  const HomeViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      HomePage(),
      const StatementPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => IndexedStack(
            index: controller.selectedIndex.value,
            children: widgetOptions,
          )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: secondaryColor,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: controller.getIconForIndex(0),
                label: 'home_icon'.tr,
              ),
              BottomNavigationBarItem(
                icon: controller.getIconForIndex(1),
                label: 'statement_icon'.tr,
              ),
              BottomNavigationBarItem(
                icon: controller.getIconForIndex(2),
                label: 'perfil_icon'.tr,
              ),
            ],
            currentIndex: controller.selectedIndex.value,
            onTap: (index) => controller.onItemTapped(index),
          )),
    );
  }
}
