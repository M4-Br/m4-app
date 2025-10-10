// lib/features/statements/controllers/statement_controller.dart

import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/extensions/dates.dart';
import 'package:app_flutter_miban4/features/statements/model/statement_response.dart';
import 'package:app_flutter_miban4/features/statements/repository/statement_repository.dart';
import 'package:get/get.dart';

class StatementController extends BaseController {
  final Rx<StatementResponse?> statements = Rx<StatementResponse?>(null);
  var selectedMonth = DateTime.now().month.obs;

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
    _fetchDataForSelectedMonth();
  }

  Future<void> changeMonth(int month) async {
    if (selectedMonth.value == month) {
      return;
    }
    selectedMonth.value = month;
    await _fetchDataForSelectedMonth();
  }

  Future<void> _fetchDataForSelectedMonth() async {
    final now = DateTime.now();
    final year = now.year;

    final startDate = DateTime(year, selectedMonth.value, 1);
    final endDate = DateTime(year, selectedMonth.value + 1, 0);

    statements.value = null;

    await fetchStatementsDetails(
      startDate: startDate.toYYYYMMDD(),
      endDate: endDate.toYYYYMMDD(),
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

      final statementsData = await StatementRepository().fetchStatements(
        accountId: account.accountId,
        startDate: startDate,
        endDate: endDate,
      );

      statements.value = statementsData;
    });
  }
}
