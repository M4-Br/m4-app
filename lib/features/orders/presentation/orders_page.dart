import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  final Color _greenDark = const Color(0xFF065F46); // Verde do topo
  final Color _bgLight = const Color(0xFFF8F9FA); // Fundo cinza clarinho
  final Color _textDark = const Color(0xFF1F2937);

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
      body: Stack(
        children: [
          // 1. Fundo verde estendido (Cria o efeito de sobreposição do card)
          Container(
            height: 100,
            width: double.infinity,
            color: _greenDark,
          ),

          // 2. Conteúdo da tela
          Column(
            children: [
              // Título
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 8, bottom: 24),
                child: Row(
                  children: const [
                    Icon(Icons.view_in_ar_outlined,
                        color: Colors.white, size: 32),
                    SizedBox(width: 12),
                    Text(
                      'Meus Pedidos',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              // Corpo limitador de largura (Para a Web)
              Expanded(
                child: CustomPageBody(
                  enableIntrinsicHeight: false,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: [
                    _buildEmptyStateCard(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- CARD BRANCO DE ESTADO VAZIO ---
  Widget _buildEmptyStateCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withValues(alpha: 0.04), // Atualizado para withValues!
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.view_in_ar_outlined,
              size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 24),
          Text(
            'Nenhum pedido ainda',
            style: TextStyle(
                color: _textDark, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Seus pedidos aparecerão aqui',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
