import 'dart:ui';
import 'package:app_flutter_miban4/core/helpers/utils/app_loading.dart';
import 'package:app_flutter_miban4/features/newsletter/controller/newsletter_controller.dart';
import 'package:app_flutter_miban4/features/newsletter/model/newsletter_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsletterPage extends GetView<NewsletterController> {
  const NewsletterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Fundo cinza claro
      appBar: AppBar(
        backgroundColor: const Color(0xFF065F46),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          _buildRedHeader(),
          _buildFilters(context),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: AppLoading());
              }

              if (controller.newsList.isEmpty) {
                return const Center(child: Text('Nenhuma notícia encontrada.'));
              }

              return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: controller.newsList.length +
                    1, // +1 para o card da IA no final
                itemBuilder: (context, index) {
                  // Se for o último item da lista, renderiza o aviso da IA
                  if (index == controller.newsList.length) {
                    return _buildAiDisclaimerCard();
                  }

                  final news = controller.newsList[index];
                  return _buildNewsCard(news);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  // --- CABEÇALHO VERMELHO ---
  Widget _buildRedHeader() {
    return Container(
      width: double.infinity,
      color: const Color(0xFF065F46),
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 24),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notícias',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Economia e negócios em destaque',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Primeira linha de filtros (Fontes)
          ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
                PointerDeviceKind.trackpad,
              },
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(() => Row(
                    // <-- Obx adicionado aqui
                    children: [
                      _buildFilterChip(
                        title: 'Todas', // Número removido
                        isSelected:
                            controller.selectedSourceFilter.value == 'Todas',
                        isRed: true,
                        onTap: () => controller.setSourceFilter('Todas'),
                      ),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                        title: 'Informativos Associa+', // Número removido
                        isSelected:
                            controller.selectedSourceFilter.value == 'Associa+',
                        onTap: () => controller.setSourceFilter('Associa+'),
                      ),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                        title: 'Notícias Externas', // Número removido
                        isSelected:
                            controller.selectedSourceFilter.value == 'Externas',
                        onTap: () => controller.setSourceFilter('Externas'),
                      ),
                    ],
                  )),
            ),
          ),
          const SizedBox(height: 12),
          // Segunda linha de filtros (Categorias)
          ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
                PointerDeviceKind.trackpad,
              },
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(() => Row(
                    // <-- Obx adicionado aqui
                    children: [
                      _buildFilterChip(
                        title: 'Todas',
                        isSelected:
                            controller.selectedCategoryFilter.value == 'Todas',
                        isRed: true,
                        icon: Icons.grid_view_rounded,
                        onTap: () => controller.setCategoryFilter('Todas'),
                      ),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                        title: 'Economia',
                        isSelected: controller.selectedCategoryFilter.value ==
                            'Economia',
                        icon: Icons.trending_up,
                        onTap: () => controller.setCategoryFilter('Economia'),
                      ),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                        title: 'Negócios',
                        isSelected: controller.selectedCategoryFilter.value ==
                            'Negócios',
                        icon: Icons.domain,
                        onTap: () => controller.setCategoryFilter('Negócios'),
                      ),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                        title: 'MEI',
                        isSelected:
                            controller.selectedCategoryFilter.value == 'MEI',
                        icon: Icons.attach_money,
                        onTap: () => controller.setCategoryFilter('MEI'),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String title,
    required bool isSelected,
    required VoidCallback onTap, // <-- Nova propriedade de clique exigida
    bool isRed = false,
    IconData? icon,
  }) {
    return GestureDetector(
      // <-- GestureDetector captura o clique do usuário
      onTap: onTap,
      child: AnimatedContainer(
        // <-- AnimatedContainer dá uma transição suave na cor
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          // Lógica de cores: Vermelho se for 'Todas', Cinza clarinho se for os outros selecionados
          color: isSelected && isRed
              ? const Color(0xFF065F46)
              : (isSelected ? Colors.grey.shade100 : Colors.white),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected && isRed
                ? const Color(0xFF065F46)
                : (isSelected ? Colors.grey.shade400 : Colors.grey.shade300),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16,
                color:
                    isSelected && isRed ? Colors.white : Colors.grey.shade700,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              title,
              style: TextStyle(
                color:
                    isSelected && isRed ? Colors.white : Colors.grey.shade800,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsCard(NewsletterModel news) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      // Adicionamos o Material e o InkWell aqui!
      child: Material(
        color: Colors.transparent, // Mantém a cor do Container pai
        child: InkWell(
          onTap: () => controller.openNews(news), // Chama a nossa nova função
          borderRadius: BorderRadius.circular(
              12), // Faz o clique respeitar as bordas arredondadas
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tag e Data
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3E8FF),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        news.category,
                        style: const TextStyle(
                          color: Color(0xFF7E22CE),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today_outlined,
                            size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          news.date,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Título
                Text(
                  news.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                // Descrição
                Text(
                  news.description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 12),
                // Fonte (e ícone indicando que é um link externo)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.article_outlined,
                            size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          news.source,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    // Opcional: Um íconezinho de "abrir" para deixar claro que é clicável
                    Icon(Icons.open_in_new,
                        size: 14, color: Colors.grey.shade400),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- AVISO DE CONTEÚDO IA (Print 2) ---
  Widget _buildAiDisclaimerCard() {
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2), // Fundo vermelho super claro
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: const Color(0xFFFECACA)), // Borda levemente vermelha
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFEE2E2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.access_time,
                color: Color(0xFFDC2626), size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Notícias Atualizadas',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Conteúdo gerado por IA com base em fontes da internet. Sempre verifique as informações nas fontes originais.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
