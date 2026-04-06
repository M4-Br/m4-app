// lib/features/accounting/page/accounting_reports_page.dart

import 'package:app_flutter_miban4/features/accounting/controller/accounting_reports_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/features/geral/widgets/app_bar.dart';

class AccountingReportsPage extends GetView<AccountingReportsController> {
  const AccountingReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const CustomAppBar(title: 'RELATÓRIOS FISCAIS'),
      body: Column(
        children: [
          _buildYearSelector(controller),
          if (controller.companyData != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: _buildCompanyHeader(controller.companyData!),
            ),
          Obx(() => Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Ano Base: ${controller.selectedYear.value}',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                ),
              )),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: secondaryColor,
                ));
              }

              if (controller.reports.isEmpty) {
                return _buildEmptyState();
              }

              return ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                itemCount: controller.reports.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final report = controller.reports[index];
                  return _buildReportCard(report, controller);
                },
              );
            }),
          ),
        ],
      ),
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
                Text('Dados da Empresa',
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

  Widget _buildYearSelector(AccountingReportsController controller) {
    return Container(
      height: 60,
      color: Colors.white,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: controller.availableYears.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final year = controller.availableYears[index];

          return Obx(() {
            final isSelected = controller.selectedYear.value == year;
            return ChoiceChip(
              label: Text(year.toString()),
              selected: isSelected,
              selectedColor: primaryColor,
              labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
              onSelected: (selected) {
                if (selected) controller.changeYear(year);
              },
            );
          });
        },
      ),
    );
  }

  Widget _buildReportCard(
      dynamic report, AccountingReportsController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.red[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.picture_as_pdf, color: Colors.red),
        ),
        title: Text(
          report.title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        subtitle: Text(
          'Gerado em: ${report.date}',
          style: TextStyle(color: Colors.grey[600], fontSize: 13),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.download_rounded, color: secondaryColor),
              onPressed: () => controller.downloadReport(report),
              tooltip: 'Baixar',
            ),
            IconButton(
              icon: const Icon(Icons.share, color: Colors.grey),
              onPressed: () => controller.shareReport(report),
              tooltip: 'Compartilhar',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.folder_off_outlined, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'Nenhum relatório encontrado para este ano.',
            style: TextStyle(color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}
