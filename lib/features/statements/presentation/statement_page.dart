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
      appBar: AppBar(
        title: const Text('Meu Extrato'),
        backgroundColor: primaryColor,
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.statements.value == null) {
          return const AppLoading();
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

        return Column(
          children: [
            Expanded(
              child: ListView.separated(
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
                      backgroundColor: primaryColor,
                      child: AppText.titleMedium(
                        context,
                        statement.dayTransaction.toString(),
                        color: amountColor,
                      ),
                    ),
                    title: AppText.bodyMedium(context, statement.description),
                    trailing:
                        AppText.bodyMedium(context, statement.amount.toBRL()),
                    onTap: () {
                      Get.toNamed(
                          '${AppRoutes.statementInvoice}${statement.idStatement}');
                    },
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
