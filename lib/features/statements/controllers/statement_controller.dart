import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/dates.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_enums.dart';
import 'package:app_flutter_miban4/features/balance/controller/balance_rx.dart';
import 'package:app_flutter_miban4/features/statements/model/statement_response.dart';
import 'package:app_flutter_miban4/features/statements/repository/statement_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatementController extends BaseController {
  final BalanceRx balance;
  StatementController({required this.balance});

  final Rx<StatementResponse?> statements = Rx<StatementResponse?>(null);
  var isVisible = false.obs;

  final Rx<DateTime> startDate = Rx<DateTime>(DateTime.now());
  final Rx<DateTime> endDate = Rx<DateTime>(DateTime.now());

  final RxInt selectedMonth = 0.obs;

  final isShowingPreviousYear = false.obs;

  final selectedAccountType = AccountType.primary.obs;

  final List<String> monthLabels = const [
    'Jan',
    'Fev',
    'Mar',
    'Abr',
    'Mai',
    'Jun',
    'Jul',
    'Ago',
    'Set',
    'Out',
    'Nov',
    'Dez'
  ];

  @override
  void onInit() {
    super.onInit();
    changeMonth(DateTime.now().month);
  }

  void toggleVisibility() {
    isVisible.value = !isVisible.value;
  }

  Future<void> switchAccount(AccountType newType) async {
    if (selectedAccountType.value == newType) return;

    selectedAccountType.value = newType;
    await fetchStatementsForCurrentRange();
  }

  Future<void> changeMonth(int month) async {
    final now = DateTime.now();
    int year = now.year;

    if (month > now.month) {
      year = now.year - 1;
    }

    if (month > now.month) {
      year = now.year - 1;
      isShowingPreviousYear.value = true;
    } else {
      isShowingPreviousYear.value = false;
    }

    selectedMonth.value = month;
    startDate.value = DateTime(year, month, 1);
    endDate.value = DateTime(year, month + 1, 0);

    await fetchStatementsForCurrentRange();
  }

  Future<void> selectDateRange(BuildContext context) async {
    final now = DateTime.now();
    final firstAllowedDate = DateTime(2020);

    DateTime safeEndDate = endDate.value;
    if (safeEndDate.isAfter(now)) {
      safeEndDate = now;
    }

    DateTime safeStartDate = startDate.value;
    if (safeStartDate.isAfter(safeEndDate)) {
      safeStartDate = safeEndDate;
    }
    if (safeStartDate.isBefore(firstAllowedDate)) {
      safeStartDate = firstAllowedDate;
    }

    final picked = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(start: safeStartDate, end: safeEndDate),
      firstDate: firstAllowedDate,
      lastDate: now,
      locale: const Locale('pt', 'BR'),
    );

    isShowingPreviousYear.value = false;

    if (picked != null) {
      selectedMonth.value = 0;
      startDate.value = picked.start;
      endDate.value = picked.end;
      await fetchStatementsForCurrentRange();
    }
  }

  Future<void> fetchStatementsForCurrentRange() async {
    statements.value = null;
    await fetchStatementsDetails(
      startDate: startDate.value.toYYYYMMDD(),
      endDate: endDate.value.toYYYYMMDD(),
    );
  }

  Future<void> fetchStatementsDetails(
      {required String startDate, required String endDate}) async {
    await executeSafe(() async {
      final currentUser = userRx.user.value;
      if (currentUser == null) {
        throw Exception('Usuário não autenticado. Impossível buscar extrato.');
      }

      final account = currentUser.payload.aliasAccount;
      if (account == null) {
        throw Exception('Conta do usuário não encontrada.');
      }

      String? accountIdToFetch;

      if (selectedAccountType.value == AccountType.economy) {
        accountIdToFetch = account.economyAccountId;
      } else {
        accountIdToFetch = account.accountId;
      }

      final statementsData = await StatementRepository().fetchStatements(
        accountId: accountIdToFetch,
        startDate: startDate,
        endDate: endDate,
      );

      statements.value = statementsData;
    }, message: 'Erro ao buscar extrato');
  }
}
