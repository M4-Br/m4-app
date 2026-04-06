import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/features/health/controller/health_attendance_controller.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';

class HealthAttendancePage extends GetView<HealthAttendanceController> {
  const HealthAttendancePage({super.key});

  final Color _greenDark = const Color(0xFF065F46);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: const CustomAppBar(title: 'Agendar Consulta'),
      body: Column(
        children: [
          _buildPatientHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildEmergencyButton(),
                  const SizedBox(height: 32),
                  const Text('Especialidades',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87)),
                  const SizedBox(height: 16),
                  _buildSpecialtiesGrid(),
                  const SizedBox(height: 40), // Espaço no final da rolagem
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- CABEÇALHO DO PACIENTE E GERENCIAMENTO DE PLANO ---
  Widget _buildPatientHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      decoration: BoxDecoration(
        color: _greenDark,
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Atendimento para:',
              style: TextStyle(color: Colors.white70, fontSize: 13)),
          const SizedBox(height: 4),
          Text(controller.patientName,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(controller.planName.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12)),
                    const SizedBox(height: 2),
                    Text('Contrato: ${controller.contractNumber}',
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 11)),
                  ],
                ),
                // --- BOTÃO DE MUDAR DE PLANO AQUI ---
                TextButton(
                  onPressed: controller.managePlan,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text('Mudar Plano',
                      style: TextStyle(
                          color: _greenDark,
                          fontSize: 11,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // --- BOTÃO DE PRONTO ATENDIMENTO EM DESTAQUE ---
  Widget _buildEmergencyButton() {
    return InkWell(
      onTap: controller.callEmergency,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          border: Border.all(color: Colors.red.shade200),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.red.shade100, shape: BoxShape.circle),
              child:
                  Icon(Icons.emergency, color: Colors.red.shade700, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pronto Atendimento 24h',
                      style: TextStyle(
                          color: Colors.red.shade900,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('Fale com um clínico geral agora mesmo.',
                      style:
                          TextStyle(color: Colors.red.shade700, fontSize: 13)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.red.shade300, size: 16),
          ],
        ),
      ),
    );
  }

  // --- GRID DE ESPECIALIDADES MOCKADAS ---
  Widget _buildSpecialtiesGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(), // Scroll é controlado pelo SingleChildScrollView pai
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio:
            1.1, // Deixa o card um pouquinho mais largo do que alto
      ),
      itemCount: controller.specialties.length,
      itemBuilder: (context, index) {
        final specialty = controller.specialties[index];
        return Material(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: InkWell(
            onTap: () => controller.selectSpecialty(specialty),
            borderRadius: BorderRadius.circular(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: specialty.color.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(specialty.icon, color: specialty.color, size: 32),
                ),
                const SizedBox(height: 12),
                Text(
                  specialty.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: 13),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
