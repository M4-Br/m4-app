import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/features/health/controller/health_terms_controller.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';

class HealthTermsPage extends GetView<HealthTermsController> {
  const HealthTermsPage({super.key});

  final Color _greenDark = const Color(0xFF065F46);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Termos de Uso'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Termos e Condições MeLife',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Ao contratar este serviço, você concorda com a disponibilização de seus dados de saúde para atendimento via telemedicina. '
                    'O plano possui carência zero para pronto atendimento 24h. '
                    'Consultas com especialistas devem ser agendadas conforme disponibilidade. '
                    '\n\nO pagamento será processado mensalmente através do seu saldo M4 ou cartão cadastrado. '
                    'O cancelamento pode ser solicitado a qualquer momento, mantendo o acesso até o fim do ciclo vigente.',
                    style: TextStyle(color: Colors.grey.shade700, height: 1.5),
                  ),
                ],
              ),
            ),
          ),

          // Área de Aceite
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Column(
              children: [
                Obx(() => Row(
                      children: [
                        Checkbox(
                          value: controller.isAccepted.value,
                          onChanged: controller.toggleAccepted,
                          activeColor: _greenDark,
                        ),
                        const Expanded(
                          child: Text(
                              'Li e concordo com os termos de uso do MeLife.'),
                        ),
                      ],
                    )),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: Obx(() => ElevatedButton(
                        onPressed: controller.isAccepted.value
                            ? () => _showPasswordDialog(context)
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _greenDark,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('CONFIRMAR CONTRATAÇÃO',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      )),
                ),
              ],
            ),
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
                'Para finalizar a contratação do plano, digite a senha do seu aplicativo M4.',
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
                    : () => controller.verifyPasswordAndContract(),
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
