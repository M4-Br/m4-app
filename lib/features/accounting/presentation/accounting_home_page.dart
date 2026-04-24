// lib/features/accounting/page/accounting_home_page.dart

import 'package:app_flutter_miban4/core/helpers/utils/app_loading.dart';
import 'package:app_flutter_miban4/features/accounting/model/accounting_summary_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/features/accounting/controller/accounting_home_controller.dart';
import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';

class AccountingHomePage extends GetView<AccountingHomeController> {
  const AccountingHomePage({super.key});

  final Color _greenDark = const Color(0xFF065F46);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const CustomAppBar(title: 'GESTÃO CONTÁBIL'),
      body: Column(
        children: [
          _buildYearSelector(),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: AppLoading());
              }

              final data = controller.summary.value;

              if (data == null) {
                return Center(
                  child: Text(
                      'Nenhum dado para ${controller.selectedYear.value}',
                      style: const TextStyle(color: Colors.grey)),
                );
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCompanyHeader(data),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Obrigações Fiscais'),
                    const SizedBox(height: 8),
                    _buildObligationsList(data),
                    const SizedBox(height: 24),
                    _buildReportsButton(),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildYearSelector() {
    return Container(
      height: 60,
      color: Colors.white,
      child: Obx(() => ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            itemCount: controller.availableYears.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final year = controller.availableYears[index];
              final isSelected = controller.selectedYear.value == year;

              return ChoiceChip(
                label: Text(year.toString()),
                selected: isSelected,
                selectedColor: _greenDark,
                labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal),
                onSelected: (selected) {
                  if (selected) controller.changeYear(year);
                },
              );
            },
          )),
    );
  }

  Widget _buildCompanyHeader(dynamic data) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Referência Contábil',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: primaryColor)),
                Icon(Icons.business, color: secondaryColor),
              ],
            ),
            const Divider(),
            _buildInfoRow('CNPJ', data.document ?? 'N/A'),
            _buildInfoRow('Classe', data.taxClass),
            _buildInfoRow('Faixa', data.incomeRange),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(color: Colors.orange.withValues(alpha: 0.3))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Imposto Devido:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                      "R\$ ${data.currentTaxDue.toStringAsFixed(2).replaceAll('.', ',')}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.green)),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text('Vencimento todo dia ${data.dueDay}',
                style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.black54)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildObligationsList(AccountingSummaryModel data) {
    final currentYearStr = controller.selectedYear.value.toString();

    final filteredHistory = data.history.where((TaxObligation item) {
      return item.monthYear.endsWith(currentYearStr);
    }).toList();

    if (filteredHistory.isEmpty) {
      return Card(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.withValues(alpha: 0.2))),
        child: const Padding(
          padding: EdgeInsets.all(32.0),
          child: Center(
            child: Text(
              'Nenhuma obrigação fiscal para este ano.',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      );
    }

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.withValues(alpha: 0.2))),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: filteredHistory.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final item = filteredHistory[index];

          final isPending = item.status == 'Pend' || item.status == 'pending';

          return ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            title: Text(item.monthYear,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            subtitle: Text(
                "R\$ ${item.value.toStringAsFixed(2).replaceAll('.', ',')}",
                style: TextStyle(color: Colors.grey[700], fontSize: 14)),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: isPending ? Colors.red[50] : Colors.green[50],
                borderRadius: BorderRadius.circular(20),
                border:
                    Border.all(color: isPending ? Colors.red : Colors.green),
              ),
              child: Text(
                isPending ? 'Pagar' : 'Pago',
                style: TextStyle(
                  color: isPending ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            onTap: () => controller.goToPayment(item),
          );
        },
      ),
    );
  }

  Widget _buildReportsButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.description_outlined),
        label: const Text('RELATÓRIOS FISCAIS'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          side: const BorderSide(color: primaryColor),
        ),
        onPressed: controller.goToReports,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black54),
    );
  }
}
