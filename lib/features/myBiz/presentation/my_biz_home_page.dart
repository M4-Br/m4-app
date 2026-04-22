import 'package:app_flutter_miban4/core/helpers/extensions/numbers.dart';
import 'package:app_flutter_miban4/core/helpers/formatters/currency_formatter.dart';
import 'package:app_flutter_miban4/features/myBiz/controller/my_biz_controller.dart';
import 'package:app_flutter_miban4/features/accounting/model/accounting_transaction_model.dart';
import 'package:app_flutter_miban4/features/geral/widgets/body_page.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyBizPage extends GetView<MyBizController> {
  const MyBizPage({super.key});

  final Color _greenDark = const Color(0xFF065F46);
  final Color _bgLight = const Color(0xFFF8F9FA);

  // ---> ADICIONE ESTA LINHA AQUI <---
  final Color _textDark = const Color(0xFF1F2937);

  // Cores dos Cards (Baseadas no print)
  final Color _colorIncome = const Color(0xFF065F46); // Verde
  final Color _colorExpense = const Color(0xFFEF4444); // Vermelho
  final Color _colorProfit = const Color(0xFF3B82F6); // Azul
  final Color _colorMargin = const Color(0xFFA855F7); // Roxo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgLight,
      appBar: AppBar(
        backgroundColor: _greenDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: CustomPageBody(
              enableIntrinsicHeight: false,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                _buildFilterRow(),
                const SizedBox(height: 16),
                _buildSummaryGrid(),
                const SizedBox(height: 24),
                _buildTabToggle(),
                const SizedBox(height: 24),
                Obx(() {
                  if (controller.isLoading.value &&
                      controller.allTransactions.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  return controller.selectedTabIndex.value == 0
                      ? _buildActualCharts() // Tab Gráficos
                      : _buildTransactionsList(); // Tab Transações
                }),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- CABEÇALHO VERDE ---
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      color: _greenDark,
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Meu Negócio',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('Gestão financeira do seu negócio',
                  style: TextStyle(color: Colors.white, fontSize: 13)),
            ],
          ),
          ElevatedButton.icon(
            onPressed: () => _showNewTransactionDialog(context),
            icon: const Icon(Icons.add, size: 16, color: Color(0xFF065F46)),
            label: const Text('Nova Transação',
                style: TextStyle(
                    color: Color(0xFF065F46),
                    fontWeight: FontWeight.bold,
                    fontSize: 12)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }

  // --- LINHA DE FILTROS DE DATA ---
  Widget _buildFilterRow() {
    final filters = ['7 dias', '30 dias', '90 dias', '1 ano', 'Todos'];

    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const Icon(Icons.filter_alt_outlined, color: Colors.grey, size: 20),
            const SizedBox(width: 8),
            ...filters.map((f) => Obx(() {
                  final isSelected = controller.selectedDateFilter.value == f;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: InkWell(
                      onTap: () => controller.applyDateFilter(f),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: isSelected ? _greenDark : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: isSelected
                              ? null
                              : Border.all(color: Colors.grey.shade300),
                        ),
                        child: Text(f,
                            style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.grey.shade700,
                                fontSize: 12,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal)),
                      ),
                    ),
                  );
                }))
          ],
        ),
      ),
    );
  }

  // --- GRID DOS CARDS COLORIDOS ---
  Widget _buildSummaryGrid() {
    return Obx(() => GridView(
          shrinkWrap: true,
          primary: false,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 220,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 100, // Altura dos cards
          ),
          children: [
            _buildMetricCard(
                'Receitas',
                controller.totalIncome.value.toPlanValue(),
                Color(0xFF065F46),
                Icons.trending_up),
            _buildMetricCard(
                'Despesas',
                controller.totalExpense.value.toPlanValue(),
                Color(0xFF065F46),
                Icons.trending_down),
            _buildMetricCard('Lucro', controller.netProfit.value.toPlanValue(),
                Color(0xFF065F46), Icons.attach_money),
            _buildMetricCard(
                'Margem',
                controller.profitMargin.value.toPlanValue(),
                Color(0xFF065F46),
                Icons.pie_chart_outline),
          ],
        ));
  }

  Widget _buildMetricCard(
      String title, String value, Color bgColor, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: bgColor.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500)),
              Icon(icon, color: Colors.white.withValues(alpha: 0.7), size: 18),
            ],
          ),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // --- TOGGLE TABS (Gráficos | Transações) ---
  Widget _buildTabToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
      child: Obx(() => Row(
            children: [
              _buildTabButton(0, 'Gráficos'),
              _buildTabButton(1, 'Transações'),
            ],
          )),
    );
  }

  Widget _buildTabButton(int index, String title) {
    final isSelected = controller.selectedTabIndex.value == index;
    return Expanded(
      child: InkWell(
        onTap: () => controller.selectedTabIndex.value = index,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2))
                  ]
                : [],
          ),
          alignment: Alignment.center,
          child: Text(title,
              style: TextStyle(
                  color: isSelected ? Colors.black87 : Colors.grey.shade600,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13)),
        ),
      ),
    );
  }

  Widget _buildActualCharts() {
    return Column(
      children: [
        // Container do Gráfico de Linhas
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Text(
                  'Evolução Financeira (${controller.selectedDateFilter.value})',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87))),
              const SizedBox(height: 32),

              // O Gráfico em si
              SizedBox(
                height: 250,
                child: Obx(() {
                  if (controller.bottomTitles.isEmpty) {
                    return const Center(
                        child: Text('Dados insuficientes para gerar o gráfico.',
                            style: TextStyle(color: Colors.grey)));
                  }

                  return LineChart(
                    LineChartData(
                      // --- 1. CONFIGURAÇÃO DO HOVER/TOOLTIP COM R$ ---
                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                          // Fundo escuro elegante para o balãozinho
                          getTooltipColor: (touchedSpot) =>
                              Colors.blueGrey.shade800,
                          getTooltipItems: (List<LineBarSpot> touchedSpots) {
                            return touchedSpots.map((spot) {
                              return LineTooltipItem(
                                spot.y
                                    .toPlanValue(), // <--- SUA EXTENSION AQUI!
                                const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              );
                            }).toList();
                          },
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: true,
                        getDrawingHorizontalLine: (value) => FlLine(
                            color: Colors.grey.withValues(alpha: 0.2),
                            strokeWidth: 1,
                            dashArray: [5, 5]),
                        getDrawingVerticalLine: (value) => FlLine(
                            color: Colors.grey.withValues(alpha: 0.2),
                            strokeWidth: 1,
                            dashArray: [5, 5]),
                      ),
                      titlesData: FlTitlesData(
                        rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              int index = value.toInt();
                              if (index >= 0 &&
                                  index < controller.bottomTitles.length) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(controller.bottomTitles[index],
                                      style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 11)),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ),
                        // --- 2. CONFIGURAÇÃO DO EIXO Y (LATERAL) COM R$ ---
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize:
                                70, // Aumentado para dar espaço pro "R$ 0.000,00"
                            getTitlesWidget: (value, meta) => Text(
                                value.toPlanValue(), // <--- SUA EXTENSION AQUI!
                                style: TextStyle(
                                    color: Colors.grey.shade600, fontSize: 11)),
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      minX: 0,
                      maxX: (controller.bottomTitles.length - 1).toDouble(),
                      minY: 0,
                      maxY: controller.maxY.value,
                      lineBarsData: [
                        LineChartBarData(
                          spots: controller.incomeSpots,
                          isCurved: true,
                          color: _colorIncome,
                          barWidth: 2,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: true),
                        ),
                        LineChartBarData(
                          spots: controller.expenseSpots,
                          isCurved: true,
                          color: _colorExpense,
                          barWidth: 2,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: true),
                        ),
                        LineChartBarData(
                          spots: controller.profitSpots,
                          isCurved: true,
                          color: _colorProfit,
                          barWidth: 2,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: true),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),

              // Legenda do Gráfico
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegendItem('Receitas', _colorIncome),
                  const SizedBox(width: 16),
                  _buildLegendItem('Despesas', _colorExpense),
                  const SizedBox(width: 16),
                  _buildLegendItem('Lucro', _colorProfit),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Blocos Inferiores
        Row(
          children: [
            Expanded(
                child: _buildCategoryBlock(
                    'Receitas por Categoria', 'Sem receitas no período')),
            const SizedBox(width: 16),
            Expanded(
                child: _buildCategoryBlock(
                    'Despesas por Categoria', 'Sem despesas no período')),
          ],
        )
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text(label,
            style: TextStyle(
                color: color, fontSize: 12, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildCategoryBlock(String title, String emptyMsg) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
          Expanded(
            child: Center(
              child: Text(emptyMsg,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
            ),
          )
        ],
      ),
    );
  }

  // --- LISTA DE TRANSAÇÕES UNIFICADA ---
  Widget _buildTransactionsList() {
    if (controller.filteredTransactions.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Text('Nenhuma transação no período.',
            style: TextStyle(color: Colors.grey)),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemCount: controller.filteredTransactions.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final tx = controller.filteredTransactions[index];
        final isIncome = tx.type == TransactionType.income;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: isIncome
                        ? const Color(0xFFD1FAE5)
                        : const Color(0xFFFEE2E2),
                    borderRadius: BorderRadius.circular(8)),
                child: Icon(
                    isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                    color: isIncome ? _colorIncome : _colorExpense,
                    size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tx.title,
                        style: TextStyle(
                            color: _textDark,
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(tx.category,
                            style: TextStyle(
                                color: Colors.grey.shade600, fontSize: 12)),
                        const SizedBox(width: 8),
                        Text('• ${DateFormat('dd/MM/yyyy').format(tx.date)}',
                            style: TextStyle(
                                color: Colors.grey.shade400, fontSize: 11)),
                      ],
                    ),
                  ],
                ),
              ),
              Text('${isIncome ? '+' : '-'} ${tx.amount.toPlanValue()}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: isIncome ? _colorIncome : _textDark)),
            ],
          ),
        );
      },
    );
  }

  // --- MODAL: NOVA TRANSAÇÃO LOCAL ---
  void _showNewTransactionDialog(BuildContext context) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        insetPadding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Lançamento Manual (Teste)',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A))),
                      IconButton(
                          icon: const Icon(Icons.close, color: Colors.grey),
                          onPressed: () => Get.back(),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints()),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Tipo (Segmented Control)
                  Obx(() => Row(
                        children: [
                          Expanded(
                              child: _buildTypeButton(TransactionType.income,
                                  'Receita', _colorIncome)),
                          const SizedBox(width: 12),
                          Expanded(
                              child: _buildTypeButton(TransactionType.expense,
                                  'Despesa', _colorExpense)),
                        ],
                      )),
                  const SizedBox(height: 16),

                  _buildTextField(
                      label: 'Título (Ex: Compra Material)',
                      controller: controller.titleController,
                      isRequired: true),
                  const SizedBox(height: 12),
                  _buildTextField(
                    label: 'Valor (R\$)',
                    controller: controller.amountController,
                    isRequired: true,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CurrencyFormatter()
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                      label: 'Categoria (Ex: Fornecedores)',
                      controller: controller.categoryController),

                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.saveLocalTransaction,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: _greenDark,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      child: const Text('Registrar Transação',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeButton(
      TransactionType type, String label, Color activeColor) {
    final isSelected = controller.selectedType.value == type;
    return InkWell(
      onTap: () => controller.selectedType.value = type,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? activeColor.withValues(alpha: 0.1)
              : Colors.transparent,
          border: Border.all(
              color: isSelected ? activeColor : Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(label,
            style: TextStyle(
                color: isSelected ? activeColor : Colors.grey.shade600,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
      ),
    );
  }

  Widget _buildTextField(
      {required String label,
      required TextEditingController controller,
      bool isRequired = false,
      TextInputType? keyboardType,
      List<TextInputFormatter>? inputFormatters}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator:
          isRequired ? (val) => val!.isEmpty ? 'Obrigatório' : null : null,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey.shade600, fontSize: 13),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF0F172A))),
      ),
    );
  }
}
