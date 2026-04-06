import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/core/helpers/utils/app_toaster.dart';
import 'package:app_flutter_miban4/features/accounting/model/accounting_transaction_model.dart';
import 'package:app_flutter_miban4/features/marketplace/repository/marketplace_sale_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MyBizController extends BaseController {
  final MarketplaceSaleRepository _repository = MarketplaceSaleRepository();
  final GetStorage _storage = GetStorage();
  final String _storageKey = 'local_accounting_db';

  // Listas
  final RxList<AppTransaction> allTransactions = <AppTransaction>[].obs;
  final RxList<AppTransaction> filteredTransactions = <AppTransaction>[].obs;

  // Filtros e Tabs
  final RxString selectedDateFilter = '30 dias'.obs;
  final RxInt selectedTabIndex = 0.obs; // 0 = Gráficos, 1 = Transações

  // Métricas
  final RxDouble totalIncome = 0.0.obs;
  final RxDouble totalExpense = 0.0.obs;
  final RxDouble netProfit = 0.0.obs;
  final RxDouble profitMargin = 0.0.obs;

  final RxList<FlSpot> incomeSpots = <FlSpot>[].obs;
  final RxList<FlSpot> expenseSpots = <FlSpot>[].obs;
  final RxList<FlSpot> profitSpots = <FlSpot>[].obs;
  final RxList<String> bottomTitles = <String>[].obs;
  final RxDouble maxY = 0.0.obs;

  // Formulário Local
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Rx<TransactionType> selectedType = TransactionType.income.obs;
  final categoryController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadAllData();
  }

  @override
  void onClose() {
    titleController.dispose();
    amountController.dispose();
    categoryController.dispose();
    super.onClose();
  }

  // --- CARREGAMENTO HÍBRIDO (API + LOCAL) ---
  Future<void> loadAllData() async {
    await executeSafe(() async {
      isLoading.value = true;
      allTransactions.clear();

      // 1. Busca Local (Testes)
      List<dynamic> storedData =
          _storage.read<List<dynamic>>(_storageKey) ?? [];
      List<AppTransaction> localData =
          storedData.map((item) => AppTransaction.fromMap(item)).toList();

      // 2. Busca API (Vendas)
      final apiSales = await _repository.getSales();

      // Traduz API para o Modelo Unificado
      List<AppTransaction> apiData = apiSales
          .map((sale) => AppTransaction(
                id: 'api_${sale.id}',
                title: sale.product?.productName ?? 'Venda Marketplace',
                amount: sale.totalValue,
                date: sale.saleDate,
                type: TransactionType.income, // Venda é sempre receita
                category: 'Marketplace',
              ))
          .toList();

      // 3. Junta tudo e ordena por data (mais recente primeiro)
      allTransactions.assignAll([...localData, ...apiData]);
      allTransactions.sort((a, b) => b.date.compareTo(a.date));

      applyDateFilter(selectedDateFilter.value);
    }, message: 'Erro ao carregar dados financeiros.');
    isLoading.value = false;
  }

  // --- FILTRO DE DATAS ---
  void applyDateFilter(String filterName) {
    selectedDateFilter.value = filterName;
    final now = DateTime.now();
    DateTime startDate;

    switch (filterName) {
      case '7 dias':
        startDate = now.subtract(const Duration(days: 7));
        break;
      case '30 dias':
        startDate = now.subtract(const Duration(days: 30));
        break;
      case '90 dias':
        startDate = now.subtract(const Duration(days: 90));
        break;
      case '1 ano':
        startDate = now.subtract(const Duration(days: 365));
        break;
      case 'Todos':
      default:
        startDate = DateTime(2000);
        break;
    }

    filteredTransactions.assignAll(allTransactions
        .where((t) =>
            t.date.isAfter(startDate) || t.date.isAtSameMomentAs(startDate))
        .toList());

    _calculateMetrics();
  }

  // --- MATEMÁTICA FINANCEIRA ---
  void _calculateMetrics() {
    double inc = 0, exp = 0;
    for (var t in filteredTransactions) {
      if (t.type == TransactionType.income) {
        inc += t.amount;
      } else {
        exp += t.amount;
      }
    }

    totalIncome.value = inc;
    totalExpense.value = exp;
    netProfit.value = inc - exp;
    profitMargin.value = inc > 0 ? (netProfit.value / inc) * 100 : 0.0;

    // --> ADICIONE ESTA LINHA AQUI <--
    _generateChartData();
  }

  // --- GERADOR DE DADOS DO GRÁFICO (Adicione no final do controller) ---
  void _generateChartData() {
    incomeSpots.clear();
    expenseSpots.clear();
    profitSpots.clear();
    bottomTitles.clear();

    if (filteredTransactions.isEmpty) {
      maxY.value = 4.0; // Escala padrão vazia
      return;
    }

    // Pega todas as datas únicas e ordena
    List<DateTime> uniqueDates = filteredTransactions
        .map((t) => DateTime(t.date.year, t.date.month, t.date.day))
        .toSet()
        .toList();

    uniqueDates.sort((a, b) => a.compareTo(b));

    double maxAmount = 0;

    for (int i = 0; i < uniqueDates.length; i++) {
      String dateKey =
          "${uniqueDates[i].day.toString().padLeft(2, '0')}/${uniqueDates[i].month.toString().padLeft(2, '0')}";
      bottomTitles.add(dateKey);

      // Soma receitas e despesas do dia
      double dailyInc = filteredTransactions
          .where((t) =>
              t.type == TransactionType.income &&
              t.date.day == uniqueDates[i].day)
          .fold(0.0, (sum, t) => sum + t.amount);
      double dailyExp = filteredTransactions
          .where((t) =>
              t.type == TransactionType.expense &&
              t.date.day == uniqueDates[i].day)
          .fold(0.0, (sum, t) => sum + t.amount);
      double dailyProf = dailyInc - dailyExp;

      incomeSpots.add(FlSpot(i.toDouble(), dailyInc));
      expenseSpots.add(FlSpot(i.toDouble(), dailyExp));
      profitSpots.add(FlSpot(i.toDouble(), dailyProf));

      // Descobre o maior valor para escalar o gráfico
      if (dailyInc > maxAmount) maxAmount = dailyInc;
      if (dailyExp > maxAmount) maxAmount = dailyExp;
      if (dailyProf > maxAmount) maxAmount = dailyProf;
    }

    maxY.value = maxAmount > 0
        ? maxAmount * 1.2
        : 4.0; // Adiciona 20% de respiro no topo
  }

  // --- SALVAR TRANSAÇÃO LOCAL ---
  void saveLocalTransaction() {
    if (!formKey.currentState!.validate()) return;

    // 1. Pega o texto limpo, ignorando qualquer coisa que não seja número
    String cleanText = amountController.text.replaceAll(RegExp(r'[^0-9]'), '');

    // 2. Se estiver vazio, define como '0'
    if (cleanText.isEmpty) cleanText = '0';

    // 3. Converte para inteiro e divide por 100 (ex: "15000" vira 150.00)
    double amount = double.parse(cleanText);

    final newTx = AppTransaction(
      id: 'local_${DateTime.now().millisecondsSinceEpoch}',
      title: titleController.text.trim(),
      amount: amount,
      date: DateTime.now(), // Salva com a data atual
      type: selectedType.value,
      category: categoryController.text.trim().isNotEmpty
          ? categoryController.text.trim()
          : 'Geral',
    );

    // Salva no Storage
    List<dynamic> storedData = _storage.read<List<dynamic>>(_storageKey) ?? [];
    storedData.add(newTx.toMap());
    _storage.write(_storageKey, storedData);

    // Atualiza a tela
    titleController.clear();
    amountController.clear();
    categoryController.clear();
    Get.back(); // Fecha Modal
    ShowToaster.toasterInfo(message: 'Transação local registrada!');

    loadAllData(); // Recarrega tudo
  }
}
