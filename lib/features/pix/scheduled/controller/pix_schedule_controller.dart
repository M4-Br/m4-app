import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/pix/scheduled/model/pix_schedule_response.dart';
import 'package:app_flutter_miban4/features/pix/scheduled/repository/pix_schedule_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PixScheduleController extends BaseController {
  final RxList<PixScheduled> scheduledPixList = <PixScheduled>[].obs;
  final RxString message = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchScheduledPix();
  }

  Future<void> fetchScheduledPix() async {
    isLoading.value = true;

    try {
      final result = await PixScheduleRepository().fetchScheduledPix();

      if (result.success == true) {
        scheduledPixList.value = result.data;
      }

      if (scheduledPixList.isEmpty) {
        message.value = 'Nenhum agendamento encontrado.';
      }
    } catch (e, s) {
      message.value = 'Erro ao buscar agendamentos.';
      AppLogger.I().error('Fetch Scheduled Pix', e, s);
    } finally {
      isLoading.value = false;
    }
  }

  Color getStatusColor(String status) {
    final s = status.toUpperCase();
    if (s.contains('AGENDADO')) return Colors.orange;
    if (s.contains('PAGO') || s.contains('SUCESSO')) return Colors.green;
    if (s.contains('CANCELADO') || s.contains('FALHA')) return Colors.red;
    return Colors.grey;
  }
}
