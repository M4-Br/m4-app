import 'package:app_flutter_miban4/core/helpers/extensions/numbers.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_button.dart';
import 'package:app_flutter_miban4/features/profile/controller/plans_controller.dart';
import 'package:app_flutter_miban4/features/profile/model/plans_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlansPage extends GetView<PlansController> {
  const PlansPage({super.key});

  final Color _greenDark = const Color(0xFF065F46);
  final Color _bgLight = const Color(0xFFF8F9FA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      appBar: AppBar(
        backgroundColor: _greenDark,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Pacotes e Planos', // Pode voltar para 'PACOTES' se preferir
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          // 1. Fundo verde estendido (A mesma identidade do Perfil)
          Container(
            height: 100,
            width: double.infinity,
            color: _greenDark,
          ),

          // 2. Conteúdo da tela
          Column(
            children: [
              Expanded(
                child: Obx(() {
                  // --- ESTADO DE LOADING ---
                  if (controller.isLoading.value &&
                      controller.plans.value == null) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }

                  // --- LISTA DE PLANOS ---
                  if (controller.plans.value != null &&
                      controller.plans.value!.isNotEmpty) {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      itemCount: controller.plans.value!.length,
                      itemBuilder: (context, index) {
                        final plan = controller.plans.value![index];
                        return _buildPlanCard(plan);
                      },
                    );
                  }

                  // --- ESTADO VAZIO / ERRO ---
                  return _buildEmptyState(context);
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- CARD DO PLANO (Visual Premium) ---
  Widget _buildPlanCard(PlanItem plan) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabeçalho do Card (Nome e Preço)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _greenDark.withValues(
                  alpha: 0.03), // Fundo super leve para o título
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    plan.description,
                    style: const TextStyle(
                      color: Color(0xFF1F2937),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      plan.monthlyPayment.toPlanValue(),
                      style: TextStyle(
                        color: _greenDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'plan_monthly'.tr, // ex: "por mês"
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),

          // Corpo do Card (Vantagens/Features)
          Padding(
            padding: const EdgeInsets.all(20),
            child: plan.data.isEmpty
                ? Text(
                    'Nenhuma vantagem cadastrada neste plano.',
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontStyle: FontStyle.italic),
                  )
                : Column(
                    children: plan.data.map((dataItem) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Ícone de check
                            Container(
                              margin: const EdgeInsets.only(top: 2, right: 12),
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8FDF5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(Icons.check,
                                  size: 12, color: Color(0xFF059669)),
                            ),

                            // Descrição do Serviço
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dataItem.typeDescription,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1F2937),
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Incluso: ${dataItem.free}', // Mostra a cota grátis
                                        style: const TextStyle(
                                            color: Color(0xFF059669),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        'Extra: ${dataItem.fee.toPlanValue()}', // Mostra o valor do excedente
                                        style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }

  // --- ESTADO VAZIO / ERRO ---
  Widget _buildEmptyState(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.assignment_late_outlined,
              size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 24),
          Text(
            'plans_empty'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Não foi possível carregar as opções agora.',
            style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: AppButton(
              buttonType: AppButtonType
                  .filled, // Ajustado para Filled para dar peso visual
              onPressed: controller.fetchPlansDetails,
              labelText: 'try_again'.tr,
            ),
          )
        ],
      ),
    );
  }
}
