import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MedicalSpecialty {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  MedicalSpecialty(
      {required this.id,
      required this.name,
      required this.icon,
      required this.color});
}

class HealthAttendanceController extends BaseController {
  late String patientName;
  late String planName;
  late String contractNumber;

  // --- MOCK DE ESPECIALIDADES ---
  final List<MedicalSpecialty> specialties = [
    MedicalSpecialty(
        id: 'clinico',
        name: 'Clínico Geral',
        icon: Icons.medical_services_outlined,
        color: const Color(0xFF2980B9)),
    MedicalSpecialty(
        id: 'psicologia',
        name: 'Psicologia',
        icon: Icons.psychology_outlined,
        color: const Color(0xFF8E44AD)),
    MedicalSpecialty(
        id: 'pediatria',
        name: 'Pediatria',
        icon: Icons.child_care,
        color: const Color(0xFFE67E22)),
    MedicalSpecialty(
        id: 'cardiologia',
        name: 'Cardiologia',
        icon: Icons.favorite_border,
        color: const Color(0xFFE74C3C)),
    MedicalSpecialty(
        id: 'nutricao',
        name: 'Nutrição',
        icon: Icons.restaurant_menu,
        color: const Color(0xFF27AE60)),
    MedicalSpecialty(
        id: 'ginecologia',
        name: 'Ginecologia',
        icon: Icons.pregnant_woman,
        color: const Color(0xFFD35400)),
    MedicalSpecialty(
        id: 'dermatologia',
        name: 'Dermatologia',
        icon: Icons.face,
        color: const Color(0xFF16A085)),
    MedicalSpecialty(
        id: 'ortopedia',
        name: 'Ortopedia',
        icon: Icons.accessible_forward,
        color: const Color(0xFF7F8C8D)),
    MedicalSpecialty(
        id: 'endocrino',
        name: 'Endocrinologia',
        icon: Icons.monitor_weight_outlined,
        color: const Color(0xFFF39C12)),
    MedicalSpecialty(
        id: 'geriatria',
        name: 'Geriatria',
        icon: Icons.elderly,
        color: const Color(0xFF34495E)),
  ];

  @override
  void onInit() {
    super.onInit();
    // Recebe os dados do cartão clicado na tela anterior
    final args = Get.arguments ?? {};
    patientName = args['patientName'] ?? 'Paciente';
    planName = args['planName'] ?? 'MeLife Essencial';
    contractNumber = args['contractNumber'] ?? 'ML-00000000-000';
  }

  void selectSpecialty(MedicalSpecialty specialty) {
    Get.toNamed(AppRoutes.healthScheduling, arguments: {
      'specialtyName': specialty.name,
      'specialtyId': specialty.id,
    });
  }

  void managePlan() {
    // Redireciona para a tela de planos para "Mudar de Plano"
    Get.toNamed(AppRoutes.healthPlans);
  }

  void callEmergency() {
    ShowToaster.toasterInfo(
        message: 'Iniciando triagem de Pronto Atendimento...');
  }
}
