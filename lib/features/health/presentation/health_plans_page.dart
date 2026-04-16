import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/features/health/controller/health_plans_controller.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_loading.dart';

class HealthPlansPage extends GetView<HealthPlansController> {
  const HealthPlansPage({super.key});

  final Color _greenDark = const Color(0xFF065F46);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: const CustomAppBar(title: 'Planos de Saúde'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: AppLoading());
        }

        return CustomPageBody(
          padding: const EdgeInsets.all(24),
          enableIntrinsicHeight:
              true, // true para o botão ficar no fundo da tela
          children: [
            // --- ILUSTRAÇÃO / ÍCONE DE DESTAQUE ---
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: _greenDark.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child:
                    Icon(Icons.health_and_safety, size: 64, color: _greenDark),
              ),
            ),
            const SizedBox(height: 32),

            // --- TEXTOS DE CHAMADA ---
            const Text(
              'Cuidar da sua saúde nunca foi tão fácil!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Conheça os planos da MeLife. Cobertura completa, atendimento rápido e os melhores profissionais à sua disposição. Tudo acessível na palma da sua mão.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15, color: Colors.grey.shade600, height: 1.4),
            ),
            const SizedBox(height: 32),

            // --- BENEFÍCIOS GERAIS (Sem preços ou limites fixos) ---
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Vantagens exclusivas:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  _buildBenefitRow(
                      Icons.videocam_outlined, 'Telemedicina 24 horas por dia'),
                  _buildBenefitRow(Icons.local_hospital_outlined,
                      'Ampla rede de especialistas'),
                  _buildBenefitRow(Icons.medication_outlined,
                      'Receitas e atestados digitais'),
                  _buildBenefitRow(Icons.card_giftcard_outlined,
                      'Clube de benefícios e descontos'),
                ],
              ),
            ),

            const Spacer(),
            const SizedBox(height: 32),

            // --- BOTÃO DE REDIRECIONAMENTO ---
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                // Passamos um nome genérico para o controller simular o aceite
                onPressed: () => controller.handleContractPlan('Plano MeLife'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _greenDark,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: const Text(
                  'VER PLANOS E CONTRATAR',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildBenefitRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: _greenDark, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
