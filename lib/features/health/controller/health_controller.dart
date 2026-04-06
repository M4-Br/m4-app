import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/core/config/auth/controller/user_rx.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HealthHomeController extends BaseController {
  final GetStorage _storage = GetStorage();
  final String _storageKey = 'mock_melife_contracted';
  final String _storagePlanKey = 'mock_melife_plan_name';
  final String _appointmentsKey = 'mock_melife_appointments';

  final RxBool isContracted = false.obs;

  final RxString planName = 'MeLife Essencial'.obs;
  final String contractNumber = 'ML-20260406-001';
  final String acquisitionDate = '06/04/2026';
  final RxString userName = 'Usuário'.obs;

  // --- NOVA LISTA REATIVA DE AGENDAMENTOS ---
  final RxList<Map<String, dynamic>> upcomingAppointments =
      <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
    _loadContractState();
    _loadAppointments(); // Carrega ao iniciar
  }

  void _loadUserData() {
    try {
      final userRx = Get.find<UserRx>();
      String? nome = userRx.user.value?.payload.fullName;
      userName.value = (nome != null && nome.isNotEmpty) ? nome : 'Usuário';
    } catch (e) {
      userName.value = 'Usuário';
    }
  }

  void _loadContractState() {
    isContracted.value = _storage.read<bool>(_storageKey) ?? false;
    planName.value =
        _storage.read<String>(_storagePlanKey) ?? 'MeLife Essencial';
  }

  // --- LÓGICA PARA BUSCAR E ORDENAR OS AGENDAMENTOS MOCKADOS ---
  void _loadAppointments() {
    List<dynamic> stored = _storage.read<List<dynamic>>(_appointmentsKey) ?? [];

    // Converte e ordena do mais próximo para o mais distante
    List<Map<String, dynamic>> parsed =
        stored.map((e) => Map<String, dynamic>.from(e)).toList();
    parsed.sort((a, b) {
      DateTime dateA = DateTime.parse(a['date']);
      DateTime dateB = DateTime.parse(b['date']);
      return dateA.compareTo(dateB); // Ordem cronológica
    });

    upcomingAppointments.assignAll(parsed);
  }

  Future<void> contractPlan() async {
    await Get.toNamed(AppRoutes.healthPlans);
    _loadContractState();
  }

  // --- O SEGREDO DO REFRESH FICA AQUI ---
  // Transforma em Future para esperar o usuário voltar do agendamento
  Future<void> openAttendance() async {
    await Get.toNamed(AppRoutes.healthAttendance, arguments: {
      'patientName': userName.value,
      'planName': planName.value,
      'contractNumber': contractNumber,
    });

    // Assim que ele finalizar o agendamento e a tela fechar, isso aqui roda:
    _loadAppointments();
  }

  void addDependent() {
    ShowToaster.toasterInfo(
        message: 'Adição de dependentes estará disponível em breve.');
  }

  void resetMock() {
    isContracted.value = false;
    _storage.remove(_storageKey);
    _storage.remove(_storagePlanKey);
    _storage.remove(_appointmentsKey); // Limpa as consultas do mock também
    upcomingAppointments.clear();
    ShowToaster.toasterInfo(message: 'Mock resetado!');
  }
}
