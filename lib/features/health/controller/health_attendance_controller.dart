import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/health/repository/health_repository.dart';
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

  final HealthRepository _repository = HealthRepository();
  final RxList<MedicalSpecialty> specialties = <MedicalSpecialty>[].obs;
  final RxBool isLoadingSpecialties = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Recebe os dados do cartão clicado na tela anterior
    final args = Get.arguments ?? {};
    patientName = args['patientName'] ?? 'Paciente';
    planName = args['planName'] ?? 'MeLife Essencial';
    contractNumber = args['contractNumber'] ?? 'ML-00000000-000';

    fetchSpecialties();
  }

  Future<void> fetchSpecialties() async {
    try {
      isLoadingSpecialties(true);
      final response = await _repository.fetchSpecialties();

      specialties.assignAll(response.map((e) => MedicalSpecialty(
            id: e.uuid,
            name: e.name,
            icon: _getIconForSpecialty(e.name),
            color: _getColorForSpecialty(e.name),
          )));
    } catch (e) {
      ShowToaster.toasterInfo(
          message: 'Erro ao carregar especialidades. Tente novamente.',
          isError: true);
    } finally {
      isLoadingSpecialties(false);
    }
  }

  IconData _getIconForSpecialty(String name) {
    final n = name.toLowerCase();
    if (n.contains('cardiologia')) return Icons.favorite_border;
    if (n.contains('dermatologia')) return Icons.face;
    if (n.contains('endocrinologia')) return Icons.monitor_weight_outlined;
    if (n.contains('geriatria')) return Icons.elderly;
    if (n.contains('ginecologia')) return Icons.pregnant_woman;
    if (n.contains('neurologia')) return Icons.psychology;
    if (n.contains('nutrição')) return Icons.restaurant_menu;
    if (n.contains('ortopedia')) return Icons.accessible_forward;
    if (n.contains('otorrinolaringologia')) return Icons.hearing;
    if (n.contains('pediatria')) return Icons.child_care;
    if (n.contains('psicologia')) return Icons.psychology_outlined;
    if (n.contains('psiquiatria')) return Icons.health_and_safety_outlined;
    if (n.contains('urologia')) return Icons.wc;
    return Icons.medical_services_outlined;
  }

  Color _getColorForSpecialty(String name) {
    final n = name.toLowerCase();
    if (n.contains('cardiologia')) return const Color(0xFFE74C3C);
    if (n.contains('dermatologia')) return const Color(0xFF16A085);
    if (n.contains('endocrinologia')) return const Color(0xFFF39C12);
    if (n.contains('geriatria')) return const Color(0xFF34495E);
    if (n.contains('ginecologia')) return const Color(0xFFD35400);
    if (n.contains('neurologia')) return const Color(0xFF8E44AD);
    if (n.contains('nutrição')) return const Color(0xFF27AE60);
    if (n.contains('ortopedia')) return const Color(0xFF7F8C8D);
    if (n.contains('otorrinolaringologia')) return const Color(0xFF2980B9);
    if (n.contains('pediatria')) return const Color(0xFFE67E22);
    if (n.contains('psicologia')) return const Color(0xFF8E44AD);
    if (n.contains('psiquiatria')) return const Color(0xFF2C3E50);
    if (n.contains('urologia')) return const Color(0xFF7F8C8D);
    return const Color(0xFF2980B9);
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
