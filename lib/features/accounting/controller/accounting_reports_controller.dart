// lib/features/accounting/controller/accounting_reports_controller.dart

import 'package:get/get.dart';
import 'package:app_flutter_miban4/features/accounting/model/accounting_report_model.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';

class AccountingReportsController extends GetxController {
  final isLoading = false.obs;

  final availableYears = List<int>.generate(10, (i) => 2025 - i);

  final selectedYear = 2024.obs;
  final reports = <AccountingReportModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchReports(selectedYear.value);
  }

  void changeYear(int year) {
    selectedYear.value = year;
    fetchReports(year);
  }

  Future<void> fetchReports(int year) async {
    isLoading.value = true;

    await Future.delayed(const Duration(milliseconds: 600));

    if (year == 2024) {
      reports.value = [
        AccountingReportModel(title: 'IRPJ Ajuste Anual', date: '10.02.2025'),
        AccountingReportModel(title: 'Declaração Simples', date: '10.01.2025'),
        AccountingReportModel(
            title: 'Resultados Exercício', date: '10.02.2025'),
      ];
    } else {
      reports.value = [];
    }

    isLoading.value = false;
  }

  void downloadReport(AccountingReportModel report) {
    ShowToaster.toasterInfo(
        message: 'Iniciando download de ${report.title}...');
  }

  void shareReport(AccountingReportModel report) {
    ShowToaster.toasterInfo(message: 'Compartilhando ${report.title}...');
  }
}
