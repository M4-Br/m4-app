import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/features/health/controller/health_scheduling_controller.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart'; // <--- IMPORT DO SEU BODY

class HealthSchedulingPage extends GetView<HealthSchedulingController> {
  const HealthSchedulingPage({super.key});

  final Color _greenDark = const Color(0xFF065F46);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(title: 'Agendar ${controller.specialtyName}'),
      body: Column(
        children: [
          // A parte rolável usa o CustomPageBody
          Expanded(
            child: CustomPageBody(
              padding: const EdgeInsets.all(24),
              children: [
                const Text('Escolha a data',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),

                // CALENDÁRIO
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: CalendarDatePicker(
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(), // Não permite passado
                    lastDate: DateTime.now()
                        .add(const Duration(days: 90)), // Até 3 meses
                    onDateChanged: controller.onDateSelected,
                    currentDate: DateTime.now(),
                  ),
                ),

                const SizedBox(height: 32),
                const Text('Escolha o horário',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),

                // GRID DE HORÁRIOS
                Obx(() {
                  if (controller.availableTimes.isEmpty) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline,
                              color: Colors.orange.shade800),
                          const SizedBox(width: 12),
                          Expanded(
                              child: Text(
                                  'Nenhum horário disponível para este dia. Escolha outra data.',
                                  style: TextStyle(
                                      color: Colors.orange.shade900))),
                        ],
                      ),
                    );
                  }

                  return Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: controller.availableTimes.map((time) {
                      final isSelected = controller.selectedTime.value == time;
                      return InkWell(
                        onTap: () => controller.onTimeSelected(time),
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 80,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected ? _greenDark : Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: isSelected
                                    ? _greenDark
                                    : Colors.grey.shade300),
                          ),
                          child: Center(
                            child: Text(
                              time,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:
                                    isSelected ? Colors.white : Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),
                const SizedBox(height: 32), // Espaço no final da rolagem
              ],
            ),
          ),

          // BOTÃO FIXO EMBAIXO
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Obx(() => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.selectedTime.value != null
                        ? () => _showPasswordDialog(context)
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _greenDark,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('CONFIRMAR AGENDAMENTO',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  void _showPasswordDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Confirme sua Senha', textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
                'Digite a senha do seu aplicativo M4 para confirmar o agendamento.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 20),
            TextField(
              controller: controller.passwordController,
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Digite sua senha',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Get.back(),
              child:
                  const Text('Cancelar', style: TextStyle(color: Colors.red))),
          Obx(() => TextButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () => controller.confirmAndSaveAppointment(),
                child: controller.isLoading.value
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('Confirmar'),
              )),
        ],
      ),
    );
  }
}
