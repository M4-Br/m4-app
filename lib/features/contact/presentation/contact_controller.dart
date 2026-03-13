import 'package:app_flutter_miban4/features/contact/controller/contact_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';

class ContactPage extends GetView<ContactController> {
  const ContactPage({super.key});

  final Color _greenDark = const Color(0xFF065F46); // Verde escuro do Header
  final Color _greenWhatsapp =
      const Color(0xFF22C55E); // Verde vibrante do card principal
  final Color _bgLight = const Color(0xFFF8F9FA); // Fundo cinza claro
  final Color _textDark = const Color(0xFF1F2937);
  final Color _textGrey = const Color(0xFF6B7280);

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
          _buildHeader(),
          Expanded(
            child: CustomPageBody(
              enableIntrinsicHeight: false, // Proteção para Grids
              crossAxisAlignment: CrossAxisAlignment.stretch,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              children: [
                _buildWhatsappCard(),
                const SizedBox(height: 16),
                _buildContactGrid(),
                const SizedBox(height: 16),
                _buildScheduleCard(),
                const SizedBox(height: 32),
                _buildFooterInfo(),
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
              Icon(Icons.chat_bubble_outline, color: Colors.white, size: 28),
              SizedBox(width: 12),
              Text(
                'Fale Conosco',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Estamos aqui para ajudar você',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ],
      ),
    );
  }

  // --- CARTÃO PRINCIPAL (WHATSAPP) ---
  Widget _buildWhatsappCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _greenWhatsapp,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: _greenWhatsapp.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.chat, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 16),
          const Text(
            'Atendimento via WhatsApp',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Entre em contato conosco através do WhatsApp para um atendimento rápido e personalizado.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 24),

          // Botão Desativado (conforme o print)
          SizedBox(
            width: 200,
            child: ElevatedButton.icon(
              onPressed: controller.openWhatsApp,
              icon: Icon(Icons.chat_bubble_outline,
                  size: 18, color: _greenDark.withOpacity(0.5)),
              label: Text('Iniciar Conversa',
                  style: TextStyle(
                      color: _greenDark.withOpacity(0.5),
                      fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.white.withOpacity(0.5), // Visual "desabilitado"
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text('Em breve disponível',
              style: TextStyle(
                  color: Colors.white.withOpacity(0.8), fontSize: 12)),
        ],
      ),
    );
  }

  // --- GRID TELEFONE E E-MAIL ---
  Widget _buildContactGrid() {
    return GridView(
      shrinkWrap: true,
      primary: false, // Fundamental para não conflitar com o scroll da página
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent:
            350, // Lado a lado no Tablet/Web, empilhado no celular se a tela for pequena
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        mainAxisExtent: 100, // Altura fixa para os cards ficarem alinhados
      ),
      children: [
        _buildInfoCard(
          icon: Icons.phone_outlined,
          iconColor: const Color(0xFF3B82F6), // Azul
          iconBgColor: const Color(0xFFDBEAFE),
          title: 'Telefone',
          desc: 'Ligue para nosso atendimento',
          onTap: controller.callPhone,
        ),
        _buildInfoCard(
          icon: Icons.mail_outline,
          iconColor: const Color(0xFF9333EA), // Roxo
          iconBgColor: const Color(0xFFF3E8FF),
          title: 'E-mail',
          desc: 'Envie sua mensagem por e-mail',
          onTap: controller.sendEmail,
        ),
      ],
    );
  }

  // --- CARTÃO DE HORÁRIO ---
  Widget _buildScheduleCard() {
    return _buildInfoCard(
      icon: Icons.access_time,
      iconColor: Colors.green,
      iconBgColor: const Color(0xFFD1FAE5),
      title: 'Horário de Atendimento',
      desc: 'Segunda a Sexta: 8h às 18h\nSábado: 8h às 12h',
      onTap: null, // Não é clicável
    );
  }

  // --- COMPONENTE REUTILIZÁVEL DOS CARDS BRANCOS ---
  Widget _buildInfoCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String desc,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: iconBgColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Icon(icon, color: iconColor, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: TextStyle(
                              color: _textDark,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(desc,
                          style: TextStyle(
                              color: _textGrey, fontSize: 13, height: 1.3)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- BANNER DE RODAPÉ (COMO PODEMOS AJUDAR?) ---
  Widget _buildFooterInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F9FF), // Azul bem clarinho
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0F2FE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Como podemos ajudar?',
              style: TextStyle(
                  color: _textDark, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
            'Nossa equipe está pronta para atender suas dúvidas sobre serviços, parcerias, benefícios e muito mais. Entre em contato e descubra como podemos impulsionar seu negócio.',
            style: TextStyle(color: _textGrey, fontSize: 13, height: 1.4),
          ),
        ],
      ),
    );
  }
}
