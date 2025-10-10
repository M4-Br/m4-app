import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/strings.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_loading.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/statements/controllers/statement_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatementPage extends GetView<StatementController> {
  const StatementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Meu Extrato',
        ),
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          _buildCard(),
          _buildMonthSelector(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value &&
                  controller.statements.value == null) {
                return const Center(child: AppLoading());
              }

              if (controller.statements.value == null ||
                  controller.statements.value!.statements.isEmpty) {
                return const Center(
                  child: Text(
                    'Nenhuma transação encontrada para este período.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              }

              final statementsList = controller.statements.value!.statements;

              return ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                itemCount: statementsList.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final statement = statementsList[index];
                  final isCredit = statement.creditFlag == 1;
                  final amountColor =
                      isCredit ? Colors.green.shade700 : Colors.redAccent;

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: amountColor.withOpacity(0.1),
                      child: Text(
                        statement.dayTransaction.toString(),
                        style: TextStyle(
                          color: amountColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: AppText.bodyMedium(context, statement.description),
                    trailing: AppText.bodyMedium(
                        context, statement.amount.toBRL(),
                        color: amountColor),
                    onTap: () {
                      Get.toNamed(
                          '${AppRoutes.statementInvoice}${statement.idStatement}');
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCard() {
    return Container();
  }

  Widget _buildMonthSelector() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white,
      child: Obx(
        () => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.monthLabels.length,
          itemBuilder: (context, index) {
            final monthNumber = index + 1;
            final isSelected = controller.selectedMonth.value == monthNumber;

            return Padding(
              padding: EdgeInsets.only(
                  left: index == 0 ? 16 : 8, right: index == 11 ? 16 : 0),
              child: GestureDetector(
                onTap: () => controller.changeMonth(monthNumber),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: isSelected ? secondaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color:
                            isSelected ? secondaryColor : Colors.grey.shade300),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: primaryColor.withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            )
                          ]
                        : [],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    controller.monthLabels[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
