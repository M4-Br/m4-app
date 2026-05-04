import 'package:app_flutter_miban4/features/cashback/controller/cashback_controller.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart'; // <-- IMPORT DO SEU WIDGET AQUI
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CashbackPage extends GetView<CashbackController> {
  const CashbackPage({super.key});

  // Cores baseadas no print
  final Color _greenPrimary = const Color(0xFF0E9F6E); // Verde principal
  final Color _bgLight = const Color(0xFFF9FAFB); // Fundo cinza clarinho
  final Color _textDark = const Color(0xFF1F2937);
  final Color _textGrey = const Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      appBar: AppBar(
        backgroundColor: _greenPrimary,
        elevation: 0,
        title: const Text('Clube de Benefícios',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          // Fundo verde no topo
          Container(
            height: 60,
            width: double
                .infinity, // <-- Adicionado para a faixa verde esticar na web
            color: _greenPrimary,
          ),

          // --- AQUI ENTRA A MÁGICA DO SEU WIDGET ---
          CustomPageBody(
            padding: const EdgeInsets.all(16.0),
            crossAxisAlignment:
                CrossAxisAlignment.start, // Mantém o alinhamento à esquerda
            children: [
              _buildMainCard(),
              const SizedBox(height: 16),
              _buildStatsRow(),
              const SizedBox(height: 24),
              _buildStoresHeader(),
              const SizedBox(height: 16),
              _buildStoresList(),
            ],
          ),
        ],
      ),
    );
  }

  // --- CARTÃO PRINCIPAL (SALDO) ---
  Widget _buildMainCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Row do Saldo
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _greenPrimary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.account_balance_wallet_outlined,
                    color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Seu saldo em cashback',
                      style: TextStyle(color: _textGrey, fontSize: 13)),
                  Obx(() => Text(
                        'R\$ ${controller.balance.value.toStringAsFixed(2).replaceAll('.', ',')}',
                        style: TextStyle(
                            color: _textDark,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Row dos Botões
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: controller.goToCoupons,
                  icon: const Icon(Icons.card_giftcard,
                      size: 18, color: Colors.white),
                  label: const Text('Ver cupons',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _greenPrimary,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: controller.goToStores,
                  icon: Icon(Icons.storefront_outlined,
                      size: 18, color: _greenPrimary),
                  label:
                      Text('Ver lojas', style: TextStyle(color: _greenPrimary)),
                  style: OutlinedButton.styleFrom(
                    side:
                        BorderSide(color: _greenPrimary.withValues(alpha: 0.5)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- LINHA DE ESTATÍSTICAS (Cupons e Lojas) ---
  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.card_giftcard,
            iconBgColor: const Color(0xFFE0E7FF), // Azul claro
            iconColor: const Color(0xFF4F46E5), // Azul escuro
            value: controller.activeCoupons.value.toString(),
            label: 'Cupons ativos',
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            icon: Icons.storefront_outlined,
            iconBgColor: const Color(0xFFF3E8FF), // Roxo claro
            iconColor: const Color(0xFF9333EA), // Roxo escuro
            value: controller.partnerStoresCount.value.toString(),
            label: 'Lojas parceiras',
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String value,
    required String label,
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
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: iconBgColor, borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value,
                  style: TextStyle(
                      color: _textDark,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              Text(label, style: TextStyle(color: _textGrey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  // --- CABEÇALHO DA LISTA DE LOJAS ---
  Widget _buildStoresHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Lojas parceiras',
            style: TextStyle(
                color: _textDark, fontSize: 16, fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: controller.seeAllStores,
          child: Row(
            children: [
              Text('Ver todas',
                  style: TextStyle(
                      color: _greenPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600)),
              const SizedBox(width: 4),
              Icon(Icons.arrow_forward, color: _greenPrimary, size: 16),
            ],
          ),
        ),
      ],
    );
  }

  // --- LISTA HORIZONTAL DE LOJAS ---
  Widget _buildStoresList() {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.mockStores.length,
        itemBuilder: (context, index) {
          final store = controller.mockStores[index];
          return Container(
            width: 130,
            margin: const EdgeInsets.only(
                right: 12, bottom: 4), // Margem bottom para a sombra
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD1FAE5), // Verde bem claro
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.storefront, color: _greenPrimary, size: 24),
                ),
                const SizedBox(height: 12),
                Text(
                  store.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: _textDark,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  store.category,
                  style: TextStyle(color: _textGrey, fontSize: 11),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
