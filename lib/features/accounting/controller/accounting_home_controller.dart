// lib/features/accounting/controller/accounting_home_controller.dart

import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/accounting/model/accounting_summary_model.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';

class AccountingHomeController extends BaseController {
  final summary = Rxn<AccountingSummaryModel>();

  @override
  void onInit() {
    super.onInit();
    _fetchAccountingData();
  }

  Future<void> _fetchAccountingData() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));

      summary.value = AccountingSummaryModel(
        cnpj: '12.345.678/0001-00',
        referenceDate: '16.Fev.2025',
        taxClass: 'Simples Nacional',
        incomeRange: '0 até 340 mil',
        currentTaxDue: 250.00,
        dueDay: 20,
        history: [
          TaxObligation(
              monthYear: 'Setembro/25', value: 250.00, status: 'Pend'),
          TaxObligation(monthYear: 'Agosto/25', value: 250.00, status: 'Ok'),
          TaxObligation(monthYear: 'Julho/25', value: 250.00, status: 'Ok'),
          TaxObligation(monthYear: 'Junho/25', value: 250.00, status: 'Ok'),
          TaxObligation(monthYear: 'Maio/25', value: 250.00, status: 'Ok'),
          TaxObligation(monthYear: 'Abril/25', value: 250.00, status: 'Ok'),
        ],
      );
    } catch (e) {
      ShowToaster.toasterInfo(message: 'Erro ao carregar dados contábeis');
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
    Get.toNamed(AppRoutes.accountingReports);
  }
}
