import 'package:app_flutter_miban4/core/helpers/utils/app_loading.dart';
import 'package:app_flutter_miban4/features/home/controller/home_icons_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeIconsController> {
  const HomePage({super.key});

  final Color _pastelColor = const Color(0xFF8ABAA5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildCustomHeader(),
            GestureDetector(
                onTap: () => controller.openFaciapLink(),
                child: Image.asset('assets/images/home_banner_partners.png')),
            SizedBox(
              height: 16,
            ),
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
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1.2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    final item = menuItems[index];

                    return _buildGridCard(
                      title: item.title,
                      iconData: item.iconData,
                      iconColor: _pastelColor,
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

  // --- WIDGET DO CABEÇALHO (BANNER VERDE) ---
  Widget _buildCustomHeader() {
    return Container(
      width: double.infinity,
      color: const Color(0xFF065F46), // Verde escuro para o Banner
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // LADO ESQUERDO: FACIAP (Maior) + Saiba Mais (Menor)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/ic_faciap.png',
                width: 115, // Aumentado para ganhar destaque
                color: Colors.white,
              ),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: controller.openFaciapLink,
                child: Row(
                  children: const [
                    Text(
                      'SAIBA MAIS',
                      style: TextStyle(
                        color: Colors
                            .white70, // Branco levemente transparente para contraste
                        fontSize: 11, // Fonte menor
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white70,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.open_in_new, color: Colors.white70, size: 12),
                  ],
                ),
              ),
            ],
          ),

          // CENTRO: Nome do Usuário
          Obx(() {
            final nome = controller.userRx.user.value?.payload.username
                    .split(' ')
                    .first ??
                'Usuário';
            return Text(
              'Olá, $nome',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow
                  .ellipsis, // Se o nome for gigantesco, ele põe "..." e não quebra a tela
            );
          }),

          // LADO DIREITO: Notificações
          IconButton(
            onPressed: controller.openNotifications,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: Obx(() => Icon(
                  controller.notifications.hasUnreadNotifications.value
                      ? Icons.notifications_active
                      : Icons.notifications_outlined,
                  color: controller.notifications.hasUnreadNotifications.value
                      ? const Color(
                          0xFFFBBF24) // Laranja/Amarelo para chamar atenção
                      : Colors.white,
                )),
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
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.15), width: 1),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                iconData ?? Icons.grid_view_rounded,
                color: iconColor,
                size: 38,
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
