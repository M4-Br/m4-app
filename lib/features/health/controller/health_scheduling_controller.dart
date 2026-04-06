import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HealthSchedulingController extends BaseController {
  final _storage = GetStorage();
  final _secureStorage = const FlutterSecureStorage();
  final String _appointmentsKey = 'mock_melife_appointments';

  late String specialtyName;
  late String specialtyId;

  final selectedDate = Rxn<DateTime>();
  final selectedTime = Rxn<String>();
  final availableTimes = <String>[].obs;

  final passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments ?? {};
    specialtyName = args['specialtyName'] ?? 'Consulta Médica';
    specialtyId = args['specialtyId'] ?? 'geral';

    // Inicia com a data de hoje e gera os horários
    selectedDate.value = DateTime.now();
    _generateTimeSlots();
  }

  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }

  void onDateSelected(DateTime date) {
    selectedDate.value = date;
    selectedTime.value = null; // Limpa o horário se mudar o dia
    _generateTimeSlots();
  }

  void onTimeSelected(String time) {
    selectedTime.value = time;
  }

  void _generateTimeSlots() {
    if (selectedDate.value == null) return;

    availableTimes.clear();
    DateTime now = DateTime.now();
    bool isToday = selectedDate.value!.year == now.year &&
        selectedDate.value!.month == now.month &&
        selectedDate.value!.day == now.day;

    // Gera de 07:00 até as 19:00
    for (int hour = 7; hour <= 19; hour++) {
      for (int minute in [0, 30]) {
        // Encerra exatamente às 19:00 (não cria 19:30)
        if (hour == 19 && minute == 30) continue;

        // Se o dia escolhido for hoje, oculta horários do passado (com folga de 30 mins)
        if (isToday) {
          if (hour < now.hour || (hour == now.hour && minute <= now.minute)) {
            continue;
          }
        }

        String h = hour.toString().padLeft(2, '0');
        String m = minute.toString().padLeft(2, '0');
        availableTimes.add('$h:$m');
      }
    }
  }

  Future<void> confirmAndSaveAppointment() async {
    final inputPassword = passwordController.text;

    if (inputPassword.isEmpty) {
      ShowToaster.toasterInfo(
          message: 'Digite sua senha para confirmar.', isError: true);
      return;
    }

    isLoading.value = true;

    try {
      final String? savedPassword =
          await _secureStorage.read(key: 'user_password');
      await Future.delayed(const Duration(seconds: 2));

      if (inputPassword == savedPassword) {
        // --- SALVANDO O AGENDAMENTO LOCALMENTE ---
        List<dynamic> currentAppointments =
            _storage.read<List<dynamic>>(_appointmentsKey) ?? [];

        final appointment = {
          'id': DateTime.now().millisecondsSinceEpoch.toString(),
          'specialty': specialtyName,
          'doctor': 'Dr(a). Associado MeLife', // Mock do médico
          'date': selectedDate.value!.toIso8601String(),
          'time': selectedTime.value,
          'status': 'scheduled',
        };

        currentAppointments.add(appointment);
        _storage.write(_appointmentsKey, currentAppointments);

        isLoading.value = false;

        // Retorna até o Painel do Titular para recarregar
        Get.until((route) => route.settings.name == AppRoutes.healthHome);
        ShowToaster.toasterInfo(message: 'Consulta agendada com sucesso!');
      } else {
        isLoading.value = false;
        ShowToaster.toasterInfo(message: 'Senha incorreta.', isError: true);
      }
    } catch (e) {
      isLoading.value = false;
      ShowToaster.toasterInfo(
          message: 'Erro ao validar agendamento.', isError: true);
    }
  }
}
