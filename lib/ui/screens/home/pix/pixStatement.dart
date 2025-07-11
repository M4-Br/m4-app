import 'package:app_flutter_miban4/data/api/pix/pixStatement.dart';
import 'package:app_flutter_miban4/data/model/pix/pixStatement.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixHome.dart';
import 'package:app_flutter_miban4/ui/screens/home/statement/statement_voucher_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class PixStatementPage extends StatefulWidget {
  const PixStatementPage({Key? key}) : super(key: key);

  @override
  State<PixStatementPage> createState() => _PixStatementPageState();
}

class _PixStatementPageState extends State<PixStatementPage> {
  int selectedMonth = DateTime.now().month;
  String startDate = '';
  String endDate = '';
  DateTime? start;
  DateTime? end;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('pt_BR', null);
    selectedMonth = DateTime.now().month;
    updateDates();
  }

  @override
  Widget build(BuildContext context) {
    String formatAmount(String amount) {
      // Verifica se o valor é representado como "0.100"
      if (amount.contains('.')) {
        // Converte a string para um valor decimal
        double decimalAmount = double.parse(amount);
        // Multiplica por 100 para obter o valor em centavos
        int cents = (decimalAmount * 100).toInt();
        // Retorna o valor formatado com duas casas decimais e separador de milhar
        return (cents / 100).toStringAsFixed(2).replaceAll('.', ',');
      } else {
        // Caso contrário, o valor já está no formato desejado
        // Converte para double e formata com duas casas decimais e separador de milhar
        return (double.parse(amount) / 100).toStringAsFixed(2).replaceAll('.', ',');
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarDefault(
        title: 'pix_statement'.tr,
        backPage: () =>
            Get.off(() => PixHome(), transition: Transition.leftToRight),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 50,
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      final monthName = DateFormat('MMM')
                          .format(DateTime(DateTime.now().year, index + 1))
                          .toUpperCase();
                      final isSelected = index + 1 == selectedMonth;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedMonth = index + 1;
                            updateDates();
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              monthName,
                              style: TextStyle(
                                  color:
                                      isSelected ? secondaryColor : Colors.grey,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final result = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now().add(
                        const Duration(days: 365),
                      ),
                    );

                    if (result != null) {
                      setState(() {
                        start = result.start;
                        end = result.end;
                        final formatter = DateFormat('yyyy-MM-dd');
                        startDate = formatter.format(start!);
                        endDate = formatter.format(end!);
                      });
                    }
                  },
                  child: const SizedBox(
                    width: 48.0,
                    height: 48.0,
                    child: Icon(Icons.calendar_today_outlined),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Flexible(
            child: FutureBuilder<PixStatementModel>(
              future:
                  fetchPixStatement(startDate.toString(), endDate.toString()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: secondaryColor,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('some_error'.tr),
                  );
                } else {
                  PixStatementModel statement = snapshot.data!;
                  if (statement.list.length == 0) {
                    return Center(
                      child: Text('statement_noData'.tr),
                    );
                  }
                  List<TransactionItem> filteredTransactions =
                      statement.list.where((transaction) {
                    int transactionMonth =
                        DateTime.parse(transaction.details.transactionDate)
                            .month;
                    return transactionMonth == selectedMonth;
                  }).toList();
            
                  if (filteredTransactions.length == 0) {
                    return Center(
                      child: Text(
                          'statement_noData'.tr),
                    );
                  }
                  return ListView.builder(
                    itemCount: filteredTransactions.length * 2 - 1,
                    itemBuilder: (context, index) {
                      if (index.isOdd) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Positioned(
                                top: 0,
                                child: Container(
                                  height: 10,
                                  width: 10,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: grey120,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Container(
                                  height: 20,
                                  width: 2,
                                  color: grey120,
                                ),
                              )
                            ],
                          ),
                        );
                      }
                      var extratoIndex = index ~/ 2;
                      var extrato = filteredTransactions[extratoIndex];
                      return GestureDetector(
                        onTap: () {
                          Get.to(
                            () => StatementVoucherScreen(
                              status: extrato.details.transactionStatus,
                              amount: extrato.amount,
                              beneficiary: extrato.details.payer.name,
                              documentBeneficiary:
                                  extrato.details.payer.document,
                              bank: extrato.details.payer.bankName,
                              origin: extrato.details.payee.name,
                              originDocument: extrato.details.payee.document,
                              originBank: extrato.details.payee.bankName,
                              id: extrato.id,
                              type:
                                  extrato.details.transactionStatus == 'ENVIADO'
                                      ? 'pix_send'.tr
                                      : 'pix_received'.tr,
                              date: extrato.details.transactionDate,
                            ),
                            transition: Transition.rightToLeft,
                          );
                        },
                        child: ListTile(
                          title: Text(
                            DateFormat('dd/MM/yyyy').format(DateTime.parse(
                                extrato.details.transactionDateFormatted)),
                            style: const TextStyle(fontSize: 12),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                extrato.details.transactionStatus,
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                extrato.details.transactionType == 1
                                    ? extrato.details.payee.name
                                    : extrato.details.payer.name,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              ),
                            ],
                          ),
                          trailing: Text(
                            '${extrato.details.transactionStatus == "ENVIADO" ? '-' : '+'} R\$ ${formatAmount(extrato.amount.toString())}',
                            style: TextStyle(
                              color: extrato.details.transactionStatus == "ENVIADO" ? Colors.red : primaryColor,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  void updateDates() {
    final now = DateTime.now();
    final year = now.year;
    final selectedDateTime = DateTime(year, selectedMonth);
    final firstDayOfMonth =
        DateTime(selectedDateTime.year, selectedDateTime.month, 1);
    final lastDayOfMonth =
        DateTime(selectedDateTime.year, selectedDateTime.month + 1, 0);
    final formatter = DateFormat('yyyy-MM-dd');
    startDate = formatter.format(firstDayOfMonth);
    endDate = formatter.format(lastDayOfMonth);
  }
}
