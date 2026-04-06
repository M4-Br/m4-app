import 'package:app_flutter_miban4/core/helpers/utils/app_loading.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/features/health/controller/health_controller.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart'; // <--- O SEU CUSTOM BODY

class HealthHomePage extends GetView<HealthHomeController> {
  const HealthHomePage({super.key});

  final Color _greenDark = const Color(0xFF065F46);
  final Color _bgLight = const Color(0xFFF8F9FA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      appBar: const CustomAppBar(title: 'Telemedicina'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: AppLoading());
        }

        return controller.isContracted.value
            ? _buildContractedState(context)
            : _buildUncontractedState(context);
      }),
    );
  }

  // ==========================================
  // TELA 1: NÃO CONTRATADO (ÁREA DE VENDAS)
  // ==========================================
  Widget _buildUncontractedState(BuildContext context) {
    // Trocado de Column/Padding para CustomPageBody
    return CustomPageBody(
      padding: const EdgeInsets.all(24.0),
      children: [
        const SizedBox(height: 40), // Substituindo o Spacer inicial
        // Logo MeLife
        Image.asset(
          'assets/images/me_life_logo.png',
          height: 150,
          errorBuilder: (context, error, stackTrace) => Container(
            height: 80,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
                child:
                    Text('Logo MeLife', style: TextStyle(color: Colors.grey))),
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          'Sua saúde na palma da mão',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937)),
        ),
        const SizedBox(height: 16),
        Text(
          'Com o MeLife, você tem acesso a médicos 24 horas por dia, sem sair de casa. Consultas rápidas, seguras e com profissionais qualificados.',
          textAlign: TextAlign.center,
          style:
              TextStyle(fontSize: 15, color: Colors.grey.shade600, height: 1.5),
        ),
        const SizedBox(height: 40),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _greenDark.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _greenDark.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: _greenDark),
              const SizedBox(width: 12),
              const Expanded(
                child: Text('Atendimento ilimitado via chamada de vídeo.',
                    style: TextStyle(fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
        const Spacer(),
        const SizedBox(
            height: 24), // Margem extra caso o Spacer suma em telas menores
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: controller.contractPlan,
            style: ElevatedButton.styleFrom(
              backgroundColor: _greenDark,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('CONTRATAR AGORA',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // ==========================================
  // TELA 2: JÁ CONTRATADO (PAINEL DO USUÁRIO)
  // ==========================================
  Widget _buildContractedState(BuildContext context) {
    // Trocado de SingleChildScrollView para CustomPageBody
    return CustomPageBody(
      padding: const EdgeInsets.all(20.0),
      enableIntrinsicHeight: false,
      children: [
        Center(
          child: GestureDetector(
            onLongPress: controller
                .resetMock, // Segure a logo para resetar o mock nos testes!
            child: Image.asset(
              'assets/images/me_life_logo.png',
              height: 50,
              errorBuilder: (context, error, stackTrace) => const Text('MeLife',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)),
            ),
          ),
        ),
        const SizedBox(height: 32),

        const Text('Meu Plano',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87)),
        const SizedBox(height: 12),

        // CARTÃO DO TITULAR
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: controller.openAttendance,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF0F2027),
                    Color(0xFF203A43),
                    Color(0xFF2C5364)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => Text(controller.planName.value.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1))),
                      const Icon(Icons.health_and_safety,
                          color: Colors.white, size: 28),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // --- ÁREA DO NOME E ÍCONE DE CLIQUE ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() => Text(controller.userName.value,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))),
                            const SizedBox(height: 4),
                            const Text('Titular',
                                style: TextStyle(
                                    color: Colors.white54, fontSize: 13)),
                          ],
                        ),
                      ),

                      // O "Chevron" indicando que é clicável
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.1),
                            shape: BoxShape.circle),
                        child: const Icon(Icons.arrow_forward_ios,
                            color: Colors.white, size: 16),
                      )
                    ],
                  ),
                  // -------------------------------------

                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Contrato',
                              style: TextStyle(
                                  color: Colors.white54, fontSize: 11)),
                          Text(controller.contractNumber,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text('Adesão',
                              style: TextStyle(
                                  color: Colors.white54, fontSize: 11)),
                          Text(controller.acquisitionDate,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 32),
        const Text('Dependentes',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87)),
        const SizedBox(height: 12),

        // BOTÃO ADICIONAR DEPENDENTE
        InkWell(
          onTap: controller.addDependent,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300, width: 2),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: _greenDark.withValues(alpha: 0.1),
                      shape: BoxShape.circle),
                  child:
                      Icon(Icons.person_add_alt_1, color: _greenDark, size: 28),
                ),
                const SizedBox(height: 12),
                const Text('Adicionar Dependente',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87)),
                const SizedBox(height: 4),
                Text('Estenda seu plano para a família',
                    style:
                        TextStyle(fontSize: 13, color: Colors.grey.shade500)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // --- SESSÃO DE AGENDAMENTOS ---
        _buildUpcomingAppointments(),

        const SizedBox(height: 24),
      ],
    );
  }

  // --- CARDS DE PRÓXIMAS CONSULTAS ---
  Widget _buildUpcomingAppointments() {
    return Obx(() {
      if (controller.upcomingAppointments.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Próximas Consultas',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.upcomingAppointments.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final apt = controller.upcomingAppointments[index];

              final date = DateTime.parse(apt['date']);
              final months = [
                'Jan',
                'Fev',
                'Mar',
                'Abr',
                'Mai',
                'Jun',
                'Jul',
                'Ago',
                'Set',
                'Out',
                'Nov',
                'Dez'
              ];
              final formattedDate =
                  '${date.day.toString().padLeft(2, '0')} ${months[date.month - 1]}';

              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 5,
                        offset: const Offset(0, 2))
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: _greenDark.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(formattedDate,
                              style: TextStyle(
                                  color: _greenDark,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                          const SizedBox(height: 4),
                          Text(apt['time'],
                              style: TextStyle(
                                  color: _greenDark,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(apt['specialty'],
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87)),
                          const SizedBox(height: 4),
                          Text(apt['doctor'],
                              style: TextStyle(
                                  fontSize: 13, color: Colors.grey.shade600)),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.videocam_outlined,
                                  size: 16, color: Colors.blue.shade700),
                              const SizedBox(width: 4),
                              Text('Vídeo Chamada',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue.shade700,
                                      fontWeight: FontWeight.w500)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 32),
        ],
      );
    });
  }
}
