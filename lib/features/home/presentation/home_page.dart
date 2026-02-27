import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/config/auth/controller/user_rx.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_loading.dart';
import 'package:app_flutter_miban4/features/balance/presentation/card_widget.dart';
import 'package:app_flutter_miban4/features/home/controller/home_icons_controller.dart';
import 'package:app_flutter_miban4/features/home/presentation/widgets/home_icons.dart';
import 'package:app_flutter_miban4/features/home/presentation/widgets/clipper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeIconsController> {
  HomePage({super.key});

  final _user = Get.find<UserRx>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _buildBackgroundWaves(),
          Column(
            children: [
              const SizedBox(height: 100),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: CardWidget(),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: AppLoading());
                  }

                  final menuItems = controller.combinedMenuList;

                  if (menuItems.isEmpty) {
                    return const Center(
                        child: Text('Nenhum serviço disponível'));
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, bottom: 20, top: 0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.0,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      final item = menuItems[index];
                      return HomeIcons(
                        iconUrl: item.iconPath ?? '',
                        iconData: item.iconData,
                        text: item.title,
                        isLocal: item.isLocal,
                        onPressed: () =>
                            controller.onMenuOptionTap(item.id, item.title),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
          _buildHeader(),
        ],
      ),
    );
  }

  Widget _buildBackgroundWaves() {
    return Stack(
      children: [
        ClipPath(
          clipper: BackWaveClipper(),
          child: Container(color: secondaryColor, height: 280),
        ),
        ClipPath(
          clipper: FrontWaveClipper(),
          child: Container(color: primaryColor, height: 240),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Positioned(
      top: 40,
      left: 16,
      right: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: controller.openAiSearch,
            icon: const Icon(
              Icons.assistant,
              color: Colors.white,
            ),
          ),
          Obx(() => Expanded(
                child: Text(
                  _user.user.value?.payload.username ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              )),
          IconButton(
            onPressed: controller.openNotifications,
            icon: Obx(() => Icon(
                  controller.notifications.hasUnreadNotifications.value
                      ? Icons.notifications_active
                      : Icons.notifications,
                  color: controller.notifications.hasUnreadNotifications.value
                      ? Colors.red
                      : Colors.white,
                  size: 32,
                )),
          ),
        ],
      ),
    );
  }
}
