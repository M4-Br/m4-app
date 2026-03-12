import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_loading.dart';
import 'package:app_flutter_miban4/features/home/controller/home_icons_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeIconsController> {
  HomePage({super.key});

  final Map<String, Color> _iconColors = {
    'cashback': const Color(0xFF1ABC9C),
    'marketplace': const Color(0xFFE67E22),
    'financial': const Color(0xFF3498DB),
    'credit': const Color(0xFF9B59B6),
    'news': const Color(0xFFE74C3C),
    'mei': const Color(0xFF2980B9),
    'ai': const Color(0xFF16A085),
    'stock': const Color(0xFF34495E),
    'accounting': const Color(0xFF8E44AD),
    'partners': const Color(0xFF1E00AD),
    'clients': const Color(0xFF2C3E50),
    'contact': const Color(0xFF00B8D4),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF8F9FA), // Fundo levemente cinza do print
      body: SafeArea(
        child: Column(
          children: [
            _buildCustomHeader(),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: AppLoading());
                }

                final menuItems = controller.combinedMenuList;

                if (menuItems.isEmpty) {
                  return const Center(child: Text('Nenhum serviço disponível'));
                }

                return GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 colunas como no print
                    childAspectRatio: 1.4, // Ajuste para ficar retangular
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    final item = menuItems[index];
                    final iconColor = _iconColors[item.id] ?? primaryColor;

                    return _buildGridCard(
                      title: item.title,
                      iconData: item.iconData,
                      iconColor: iconColor,
                      onTap: () =>
                          controller.onMenuOptionTap(item.id, item.title),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET DO CABEÇALHO ---
  Widget _buildCustomHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Lado Esquerdo: Saudação e FACIAP
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/ic_faciap.png',
                width: 100,
                color: Colors.green,
              ),
              const SizedBox(height: 12),
              Obx(() => Text(
                    'Olá, ${controller.userRx.user.value?.payload.username.split(' ').first ?? 'Usuário'}',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ],
          ),

          Row(
            children: [
              IconButton(
                onPressed: controller.openAiSearch,
                icon: const Icon(Icons.auto_awesome_outlined,
                    color: Colors.black87),
              ),
              IconButton(
                onPressed: controller.openNotifications,
                icon: Obx(() => Icon(
                      controller.notifications.hasUnreadNotifications.value
                          ? Icons.notifications_active
                          : Icons.notifications_outlined,
                      color:
                          controller.notifications.hasUnreadNotifications.value
                              ? Colors.red
                              : Colors.black87,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- WIDGET DO CARD DE SERVIÇO ---
  Widget _buildGridCard({
    required String title,
    required IconData? iconData,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      // REMOVIDO: borderRadius: BorderRadius.circular(16), <-- Era isso que estava causando o erro
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            16), // O arredondamento fica apenas aqui agora
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.15), width: 1),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(
            16), // No InkWell precisa manter para o efeito de clique não vazar
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                iconData ?? Icons.grid_view_rounded,
                color: iconColor,
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
