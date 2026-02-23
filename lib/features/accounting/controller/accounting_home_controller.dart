// lib/features/accounting/controller/accounting_home_controller.dart

import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/accounting/model/accounting_summary_model.dart';
import 'package:app_flutter_miban4/features/accounting/repository/accounting_repository.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';

class AccountingHomeController extends BaseController {
  final summary = Rxn<AccountingSummaryModel>();

  final availableYears = <int>[].obs;
  final selectedYear = DateTime.now().year.obs;

  @override
  void onInit() {
    super.onInit();
    _generateYears();
    fetchAccountingData();
  }

  void _generateYears() {
    final currentYear = DateTime.now().year;
    availableYears.value = List.generate(4, (index) => currentYear - index);
  }

  void changeYear(int year) {
    if (selectedYear.value != year) {
      selectedYear.value = year;
      fetchAccountingData();
    }
  }

  Future<void> fetchAccountingData() async {
    try {
      isLoading.value = true;
      final response = await AccountingRepository()
          .fetchAccounting(year: selectedYear.value);

      summary.value = response;
    } catch (e) {
      summary.value = null;
      ShowToaster.toasterInfo(
          message:
              'Nenhum dado ou erro ao carregar o ano de ${selectedYear.value}');
    } finally {
      isLoading.value = false;
    }
  }

  void goToPayment(TaxObligation obligation) {
    if (obligation.status == 'Pend') {
      Get.toNamed(AppRoutes.accountingPayment);
    }
  }

  void goToReports() {
    final currentSummary = summary.value;
    if (currentSummary != null) {
      Get.toNamed(AppRoutes.accountingReports, arguments: currentSummary);
    } else {
      ShowToaster.toasterInfo(
          message: 'Aguarde o carregamento dos dados da empresa.');
    }
  }
}
