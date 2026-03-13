import 'package:app_flutter_miban4/features/partners/controller/partners_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';

class PartnersPage extends GetView<PartnersController> {
  const PartnersPage({super.key});

  final Color _greenDark = const Color(0xFF065F46); // Verde escuro do Header
  final Color _greenPrimary =
      const Color(0xFF059669); // Verde dos botões/ícones
  final Color _bgLight = const Color(0xFFF8F9FA); // Fundo geral
  final Color _textDark = const Color(0xFF1F2937);
  final Color _textGrey = const Color(0xFF4B5563);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      appBar: AppBar(
        backgroundColor: _greenDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text('Voltar',
            style: TextStyle(color: Colors.white, fontSize: 16)),
        titleSpacing: 0,
      ),
      body: Column(
        children: [
          _buildHeader(), // Fica de fora para esticar na Web
          Expanded(
            child: CustomPageBody(
              enableIntrinsicHeight:
                  false, // Fundamental para não dar erro com os Grids/Lists
              crossAxisAlignment: CrossAxisAlignment.stretch,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              children: [
                _buildTopInfoCards(),
                const SizedBox(height: 24),
                _buildAdvantagesList(),
                const SizedBox(height: 32),
                const Text(
                  'Parceiros Principais',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827)),
                ),
                const SizedBox(height: 16),
                _buildMainPartnersList(),
                const SizedBox(height: 32),
                const Text(
                  'Outros Parceiros',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827)),
                ),
                const SizedBox(height: 16),
                _buildOtherPartnersGrid(),
                const SizedBox(height: 32),
                _buildCtaBanner(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- CABEÇALHO VERDE ESCURO ---
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      color: _greenDark,
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.handshake_outlined, color: Colors.white, size: 32),
              SizedBox(width: 12),
              Text(
                'Nossos Parceiros',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Empresas e instituições que apoiam o desenvolvimento empresarial',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ],
      ),
    );
  }

  // --- CARDS DO TOPO (Benefícios / Como se beneficiar) ---
  Widget _buildTopInfoCards() {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent:
            400, // Responsivo: lado a lado na Web, empilhado no Celular
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        mainAxisExtent: 130, // Altura fixa para alinhar os dois cards
      ),
      children: [
        _buildInfoCard(
          icon: Icons.auto_awesome,
          iconColor: _greenPrimary,
          iconBgColor: const Color(0xFFD1FAE5),
          title: 'Benefícios para Você',
          desc:
              'Acesso a uma série de benefícios que incluem serviços e recursos estratégicos para fortalecer sua atividade empresarial.',
        ),
        _buildInfoCard(
          icon: Icons.domain,
          iconColor: const Color(0xFF2563EB),
          iconBgColor: const Color(0xFFDBEAFE),
          title: 'Como Me Beneficiar?',
          desc:
              'Basta se associar à associação comercial mais próxima para aproveitar todos os recursos oferecidos pelos parceiros.',
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String desc,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: iconBgColor, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        color: _textDark,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(desc,
                    style:
                        TextStyle(color: _textGrey, fontSize: 12, height: 1.3),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- LISTA DE VANTAGENS (Checkmarks) ---
  Widget _buildAdvantagesList() {
    final vantagens = [
      'Descontos exclusivos em produtos e serviços',
      'Condições especiais de crédito',
      'Apoio em eventos e iniciativas',
      'Consultoria e capacitação empresarial',
      'Networking e oportunidades de negócio',
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.check_circle_outline, color: _greenPrimary, size: 20),
              const SizedBox(width: 8),
              Text('Vantagens das Parcerias',
                  style: TextStyle(
                      color: _textDark,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          ...vantagens.map((v) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  children: [
                    Icon(Icons.check_circle_outline,
                        color: _greenPrimary, size: 18),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Text(v,
                            style: TextStyle(color: _textGrey, fontSize: 14))),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  // --- LISTA DE PARCEIROS PRINCIPAIS ---
  Widget _buildMainPartnersList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.mainPartners.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final partner = controller.mainPartners[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2)),
            ],
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Caixa da Logo
                Container(
                  width: 100,
                  height: 60,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Center(
                    child: Image.asset(
                      partner.logoAsset,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.image_not_supported,
                          color:
                              Colors.grey), // Fallback se a imagem não existir
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Textos
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(partner.name,
                          style: TextStyle(
                              color: _textDark,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text(partner.description,
                          style: TextStyle(
                              color: _textGrey, fontSize: 13, height: 1.4)),
                      if (partner.url != null) ...[
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () =>
                              controller.openUrl(partner.url, partner.name),
                          child: Row(
                            children: [
                              Text('Saiba mais',
                                  style: TextStyle(
                                      color: _greenPrimary,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(width: 4),
                              Icon(Icons.open_in_new,
                                  color: _greenPrimary, size: 14),
                            ],
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // --- GRID DE OUTROS PARCEIROS ---
  Widget _buildOtherPartnersGrid() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'Descubra outras soluções inovadoras e exclusivas que oferecemos para impulsionar seu negócio!',
              style: TextStyle(color: _textGrey, fontSize: 14)),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 180, // Fica 2 no cel e vários na Web
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.8, // Formato de botão comprido
            ),
            itemCount: controller.otherPartners.length,
            itemBuilder: (context, index) {
              final op = controller.otherPartners[index];
              return OutlinedButton(
                onPressed: () => controller.openUrl(op.url, op.name),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(op.name,
                        style: TextStyle(
                            color: _textDark,
                            fontWeight: FontWeight.w600,
                            fontSize: 13)),
                    const SizedBox(width: 6),
                    const Icon(Icons.open_in_new, color: Colors.grey, size: 14),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // --- BANNER CTA VERDE GIGANTE ---
  Widget _buildCtaBanner() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: _greenPrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            'Quer aproveitar esses benefícios?',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          const Text(
            'Associe-se agora e tenha acesso a todos os recursos e vantagens oferecidos pelos nossos parceiros.',
            style: TextStyle(color: Colors.white, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: controller.goToAssociation,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Text('Saiba Como Se Associar',
                style: TextStyle(
                    color: _greenPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 15)),
          ),
        ],
      ),
    );
  }
}
