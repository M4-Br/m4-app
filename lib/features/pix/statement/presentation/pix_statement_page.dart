import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/dates.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/strings.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_dimens.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_loading.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/pix/statement/controller/pix_statement_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PixStatementPage extends GetView<PixStatementController> {
  const PixStatementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: AppText.titleLarge(
          context,
          'statement'.tr,
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () {
            FocusScope.of(context).unfocus();

            if (Get.isSnackbarOpen) Get.closeAllSnackbars();
            Navigator.of(context).maybePop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Selecionar período',
            icon: const Icon(Icons.calendar_month, color: Colors.white),
            onPressed: () => controller.selectDateRange(context),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCard(context),
          _buildMonthSelector(),
          _buildSelectedDateRange(context),
          _buildPreviousYearWarning(context, controller),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value &&
                  controller.statements.value == null) {
                return const Center(child: AppLoading());
              }

              if (controller.statements.value == null ||
                  controller.statements.value!.list.isEmpty) {
                return const Center(
                  child: Text(
                    'Nenhuma transação encontrada para este período.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              }

              final listsList = controller.statements.value!.list;

              return ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                itemCount: listsList.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final list = listsList[index];
                  final isCredit = list.details.transactionStatus == 'RECEBIDO';
                  final amountColor =
                      isCredit ? Colors.green.shade700 : Colors.redAccent;

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: amountColor.withValues(alpha: 0.1),
                      child: Text(
                        list.details.transactionDate.split('-').last,
                        style: TextStyle(
                          color: amountColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: AppText.bodyMedium(context, list.details.payer.name),
                    trailing: AppText.bodyMedium(context, list.amount.toBRL(),
                        color: amountColor),
                    onTap: () {
                      Get.toNamed('${AppRoutes.statementInvoice}${list.id}');
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

  Widget _buildCard(BuildContext context) {
    return Container(
      width: double.infinity,
      color: primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.titleLarge(
              context,
              'balance_available'.tr,
              color: Colors.white,
            ),
            Row(
              children: [
                Expanded(
                  child: Obx(() {
                    final isVisible = controller.isVisible.value;
                    final balanceValue = controller.balance.balance.value;
                    return AppText.headlineMedium(
                      context,
                      isVisible
                          ? (balanceValue?.balanceCents.toBRL() ?? 'R\$ ...')
                          : '*****',
                      color: Colors.white,
                    );
                  }),
                ),
                IconButton(
                  onPressed: () => controller.toggleVisibility(),
                  icon: Obx(
                    () => Icon(
                      controller.isVisible.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimens.kDefaultPadding),
            AppText.titleMedium(context, 'balance_transational'.tr,
                color: Colors.white),
            Obx(() {
              final isVisible = controller.isVisible.value;
              final balanceValue = controller.balance.balance.value;
              return AppText.headlineSmall(
                context,
                isVisible
                    ? (balanceValue?.transactionalValue.toBRL() ?? 'R\$ ...')
                    : '*****',
                color: Colors.white,
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthSelector() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white,
      child: Obx(() {
        final _ = controller.selectedMonth.value;

        return ListView.builder(
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
                              color: primaryColor.withValues(alpha: 0.3),
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
        );
      }),
    );
  }

  Widget _buildSelectedDateRange(BuildContext context) {
    return Obx(
      () {
        if (controller.selectedMonth.value != 0) {
          return const SizedBox.shrink();
        }

        final start = controller.startDate.value.toDDMMYYYY();
        final end = controller.endDate.value.toDDMMYYYY();
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
          color: Colors.white,
          child: Center(
            child: AppText.bodyMedium(
              context,
              'Período: $start - $end',
              color: secondaryColor,
            ),
          ),
        );
      },
    );
  }

  Widget _buildPreviousYearWarning(
      BuildContext context, PixStatementController controller) {
    return Obx(() {
      if (!controller.isShowingPreviousYear.value) {
        return const SizedBox.shrink();
      }

      final year = controller.startDate.value.year;

      return Container(
        width: double.infinity,
        color: Colors.amber.shade50,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.amber.shade800,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              'Exibindo extrato de $year',
              style: TextStyle(
                color: Colors.amber.shade900,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    });
  }
}
