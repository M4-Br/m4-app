import 'package:app_flutter_miban4/features/score/controller/score_controller.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart'; // <-- IMPORT DO SEU WIDGET
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScorePage extends GetView<ScoreController> {
  const ScorePage({super.key});

  final Color _purplePrimary = const Color(0xFF065F46);
  final Color _bgLight = const Color(0xFFF8F9FA);
  final Color _textDark = const Color(0xFF1F2937);
  final Color _textGrey = const Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      appBar: AppBar(
        backgroundColor: _purplePrimary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          _buildPurpleHeader(), // Fica de fora para esticar a tela toda na Web
          Expanded(
            // --- APLICANDO O CUSTOM PAGE BODY AQUI ---
            child: CustomPageBody(
              padding: const EdgeInsets.all(16.0),
              enableIntrinsicHeight:
                  false, // Previne o erro de rendering de viewport
              children: [
                _buildMainCard(),
                const SizedBox(height: 16),
                _buildInfoCard(
                  icon: Icons.security_outlined,
                  iconColor: _purplePrimary,
                  iconBgColor: const Color(0xFFF3E8FF),
                  title: 'Consulta Segura',
                  description:
                      'Acesso direto ao portal oficial do SPC Brasil com total segurança',
                ),
                const SizedBox(height: 12),
                _buildInfoCard(
                  icon: Icons.trending_up,
                  iconColor: const Color(0xFF2563EB),
                  iconBgColor: const Color(0xFFDBEAFE),
                  title: 'Análise de Risco',
                  description:
                      'Consulte o score e histórico dos seus clientes para avaliar o risco antes de vender a crédito',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPurpleHeader() {
    return Container(
      width: double.infinity,
      color: _purplePrimary,
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 24),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Consulta de Crédito',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Análise de risco para vendas a crédito',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Ícone centralizado
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFFF3E8FF), // Fundo roxo claro
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.bar_chart, color: _purplePrimary, size: 32),
          ),
          const SizedBox(height: 16),
          // Título
          Text(
            'Consulta SPC Brasil',
            style: TextStyle(
              color: _textDark,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          // Descrição
          Text(
            'Consulte o score e histórico de crédito dos seus clientes antes de aprovar vendas a crédito ou crediário. Analise o risco e tome decisões seguras.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: _textGrey,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          // Botão de Ação
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: controller.openSpcWebView, // Dispara a WebView
              icon:
                  const Icon(Icons.open_in_new, size: 18, color: Colors.white),
              label: const Text(
                'Acessar SPC Brasil',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _purplePrimary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- COMPONENTE DOS CARDS DE INFORMAÇÃO ---
  Widget _buildInfoCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: _textDark,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: _textGrey,
                    fontSize: 13,
                    height: 1.3,
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
