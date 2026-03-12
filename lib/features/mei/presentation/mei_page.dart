import 'package:app_flutter_miban4/features/mei/controller/mei_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:app_flutter_miban4/features/mei/controller/mei_services_controller.dart';

class MeiServicesPage extends GetView<MeiServicesController> {
  const MeiServicesPage({super.key});

  final Color _bluePrimary = const Color(0xFF3B82F6); // Azul vibrante do topo
  final Color _bgLight = const Color(0xFFF8F9FA); // Fundo cinza claro

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      appBar: AppBar(
        backgroundColor: _bluePrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Voltar',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  _buildTopBanner(),
                  const SizedBox(height: 16),
                  _buildGridServices(),
                  const SizedBox(height: 16),
                  _buildBottomBanner(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- CABEÇALHO AZUL ---
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      color: _bluePrimary,
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 8),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Serviços para MEI',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            'Tudo o que você precisa para gerir seu MEI',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }

  // --- BANNER AZUL DO TOPO (Conta com a Gente) ---
  Widget _buildTopBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF4F46E5), // Azul um pouco mais escuro/índigo
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4F46E5).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.business_center, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text(
                'MEI, Conta com a Gente',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Iniciativa do governo para facilitar o dia a dia de quem é Microempreendedor Individual',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () =>
                controller.openUrl('https://gov.br/mei', 'Conta com a Gente'),
            icon: const Icon(Icons.open_in_new,
                size: 16, color: Color(0xFF4F46E5)),
            label: const Text(
              'Saiba mais',
              style: TextStyle(
                  color: Color(0xFF4F46E5), fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          )
        ],
      ),
    );
  }

  // --- GRID DE SERVIÇOS ---
  Widget _buildGridServices() {
    return GridView.builder(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(), // Scroll quem faz é a tela inteira
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.1, // Controla a altura do cartão retangular
      ),
      itemCount: controller.services.length,
      itemBuilder: (context, index) {
        final service = controller.services[index];
        return _buildServiceCard(service);
      },
    );
  }

  Widget _buildServiceCard(MeiServiceModel service) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => controller.openUrl(service.url, service.title),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Fundo bem clarinho com o ícone colorido
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: service.iconColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(service.icon,
                          color: service.iconColor, size: 24),
                    ),
                    const Icon(Icons.open_in_new,
                        color: Colors.black26, size: 16),
                  ],
                ),
                const Spacer(),
                Text(
                  service.title,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  service.subtitle,
                  style: const TextStyle(fontSize: 10, color: Colors.black54),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- BANNER INFERIOR DO GOVERNO ---
  Widget _buildBottomBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F9FF), // Azul gelo bem claro
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0F2FE)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFDBEAFE),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.help_outline, color: _bluePrimary, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Portal Oficial do Governo',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black87),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Todos os serviços acima redirecionam para os portais oficiais do governo brasileiro, garantindo segurança e autenticidade.',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: controller.openGovPortal,
                  child: Row(
                    children: [
                      Text(
                        'Acessar portal completo',
                        style: TextStyle(
                            color: _bluePrimary,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.open_in_new, color: _bluePrimary, size: 14),
                    ],
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
