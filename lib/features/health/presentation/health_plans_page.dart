import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/features/health/controller/health_plans_controller.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart'; // <--- SEU CUSTOM BODY AQUI
import 'package:app_flutter_miban4/core/helpers/utils/app_loading.dart';

class HealthPlansPage extends GetView<HealthPlansController> {
  const HealthPlansPage({super.key});

  final Color _greenDark = const Color(0xFF065F46);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> plans = [
      {
        'title': 'Individual',
        'monthlyPrice': '25,90',
        'annualPrice': '20,90',
        'features': [
          'Consultas ilimitadas',
          'Atendimento 24/7',
          'Histórico médico digital',
          'Receitas e Atestados digitais',
          'Nutricionista - 1 sessão/90 dias',
          'Acesso total ao Clube de Benefícios'
        ],
      },
      {
        'title': 'Coletivo (Família)',
        'monthlyPrice': '59,90',
        'annualPrice': '49,90',
        'isPopular': true,
        'features': [
          'Até 4 pessoas da família',
          'Consultas ilimitadas e Atendimento 24/7',
          'Histórico, Receitas e Atestados digitais',
          'Nutricionista - 1 sessão/90 dias',
          'R\$ 12,50 por dependente extra',
          'Acesso total ao Clube de Benefícios'
        ],
      },
      {
        'title': 'Psicológico',
        'monthlyPrice': '45,90',
        'annualPrice': '39,90',
        'features': [
          '2 consultas por mês',
          'Psicólogos especializados',
          'Histórico de atendimentos',
          'Suporte contínuo',
          'Acesso total ao Clube de Benefícios'
        ],
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: const CustomAppBar(title: 'Nossos Planos'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: AppLoading());
        }

        // Trocando ListView por CustomPageBody
        return CustomPageBody(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          children: [
            // O Spacer() antes do map não é necessário a menos que queira centralizar.
            // Para criar a lista, usamos o spread operator (...) com map e adicionamos o espaçamento
            ...plans.expand((plan) {
              return [
                _buildPlanCard(plan),
                const SizedBox(
                    height: 24), // Espaçamento equivalente ao separatorBuilder
              ];
            }),
            const SizedBox(height: 16), // Espaço extra no final da rolagem
          ],
        );
      }),
    );
  }

  Widget _buildPlanCard(Map<String, dynamic> plan) {
    final bool isPopular = plan['isPopular'] ?? false;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: isPopular ? _greenDark : Colors.grey.shade200,
            width: isPopular ? 2 : 1),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isPopular)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: _greenDark,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18)),
              ),
              child: const Text('MAIS POPULAR',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 1)),
            ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Plano ${plan['title']}',
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87)),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('R\$ ',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87)),
                    Text(plan['annualPrice'],
                        style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87)),
                    const Text('/mês',
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
                Text(
                    'no plano anual (ou R\$ ${plan['monthlyPrice']} no mensal)',
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),
                ...List.generate(plan['features'].length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.check_circle, color: _greenDark, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                            child: Text(plan['features'][index],
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade700,
                                    height: 1.4))),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () =>
                        controller.goToTerms('MeLife ${plan['title']}'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isPopular ? _greenDark : Colors.white,
                      foregroundColor: isPopular ? Colors.white : _greenDark,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: _greenDark, width: 1.5),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    child: Text('CONTRATAR PLANO',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isPopular ? Colors.white : _greenDark)),
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
