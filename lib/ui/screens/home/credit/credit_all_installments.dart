import 'package:app_flutter_miban4/data/api/credit/get_all_credit.dart';
import 'package:app_flutter_miban4/data/api/groups/getMyContributions.dart';
import 'package:app_flutter_miban4/data/model/groups/contributionsModel.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/home/credit/credit_installments.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/group_contribution_id.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/group_data.dart';
import 'package:app_flutter_miban4/ui/screens/home/home_view_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreditAllInstallments extends StatefulWidget {
  final int id;
  final String type;

  const CreditAllInstallments({
    Key? key,
    required this.id,
    required this.type,
  }) : super(key: key);

  @override
  State<CreditAllInstallments> createState() => _CreditAllInstallmentsState();
}

class _CreditAllInstallmentsState extends State<CreditAllInstallments> {
  late Future<List<Map<String, dynamic>>> _contributions;

  bool _isActive = true;
  int _screenActivity = 0;

  @override
  void initState() {
    super.initState();
    _loadContributions();
  }

  void _loadContributions() {
    setState(() {
      _contributions =
          getCreditAllInstallments(widget.id.toString(), widget.type);
    });
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: '');
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBarDefault(
        title: AppLocalizations.of(context)!.credit_credit.toUpperCase(),
        backPage: () =>
            Get.off(
              HomeViewPage(),
              transition: Transition.leftToRight,
            ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _contributions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(
                  color: secondaryColor,
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              color: Colors.white,
              child: Center(
                child: Text(
                  snapshot.error.toString(),
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              color: Colors.white,
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.dont_have_credit,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            );
          } else {
            bool allPaid = snapshot.data!
                .every((transaction) => transaction['status'] == 'success');

            double totalAmount = snapshot.data!
                .where((transaction) => transaction['status'] == 'success')
                .map((transaction) => transaction['amount'] as int? ?? 0)
                .fold(0, (previous, amount) => previous + amount);

            double totalOpen = snapshot.data!
                .where((transaction) => transaction['status'] == 'pending')
                .map((transaction) => transaction['amount'] as int? ?? 0)
                .fold(0, (previous, amount) => previous + amount);

            String nextPaymentDate = '';
            for (var transaction in snapshot.data!) {
              if (transaction['status'] == 'pending') {
                nextPaymentDate =
                    dateFormat.format(DateTime.parse(transaction['due_date']));
                break;
              }
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .credit_paid_installment,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            'R\$ ${currencyFormat.format(totalAmount / 100)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.credit_next_payment,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            nextPaymentDate.isNotEmpty
                                ? nextPaymentDate
                                : AppLocalizations.of(context)!
                                .credit_all_installments_paid,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _isActive = !_isActive;
                            _screenActivity = 0;
                          });
                        },
                        child: Container(
                          height: 60,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                            ),
                            color: Color(0xFF02010f),
                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.group_open,
                              style: TextStyle(
                                  color: _isActive
                                      ? Colors.white
                                      : Colors.white54),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _isActive = !_isActive;
                            _screenActivity = 1;
                          });
                        },
                        child: Container(
                          height: 60,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                            ),
                            color: Color(0xFF02010f),
                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.group_paid,
                              style: TextStyle(
                                  color: !_isActive
                                      ? Colors.white
                                      : Colors.white54),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    color: const Color(0xFFe9eaf0),
                    child: _screenActivity == 0
                        ? _buildTransactionList(
                      snapshot.data!.where((transaction) => transaction['status'] == 'pending').toList(),
                      'pending',
                      totalAmount,
                      allPaid,
                      true,
                    )
                        : _buildTransactionList(
                      snapshot.data!.where((transaction) => transaction['status'] == 'success').toList(),
                      'success',
                      totalAmount,
                      false,
                      false,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildTransactionList(List<Map<String, dynamic>> transactions,
      String status,
      double amount,
      bool allInstalments,
      bool checkFirstPending,) {
    if (allInstalments == true) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.all_paid,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black, fontSize: 18),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];

          if (transaction['status'] == status) {
            bool isFirstPending = checkFirstPending && index != 0;
            return _buildTransactionCard(
              transaction,
              transactions.length.toString(),
              amount,
              transactions.length,
              index,
              isFirstPending,
            );
          }

          return const SizedBox.shrink();
        },
      );
    }
  }


  Widget _buildTransactionCard(Map<String, dynamic> transaction,
      String installment,
      double amount,
      int totalInstallment,
      int index,
      bool isFirstPending,) {
    final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: '');
    final dateFormat = DateFormat('dd/MM/yyyy');

    return InkWell(
      onTap: () {
        if (transaction['status'] == 'pending') {
          if (isFirstPending) {
            Get.dialog(AlertDialog(
              title: Text(
                AppLocalizations.of(context)!.message,
                textAlign: TextAlign.center,
              ),
              content: Text(
                AppLocalizations.of(context)!.first_installment,
                textAlign: TextAlign.center,
              ),
              actions: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
                        ),
                      ),
                      child: const Text(
                        'OK',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                )
              ],
            ));
          } else {
            DateTime today = DateTime.now();
            DateTime todayAtMidnight = DateTime(today.year, today.month, today.day);

            Map<String, dynamic> creditInstallmentMap = {
              'id': transaction['id'],
              'dueDate': transaction['due_date'],
              'amount': DateTime.parse(transaction['due_date']).isBefore(
                  todayAtMidnight)
                  ? int.parse(transaction['amount_with_interest'].toString())
                  : transaction['amount'],
              'status': transaction['status'],
              'installment': transaction['installment'],
              'total_installment': totalInstallment,
              'document': transaction['destination_account']['document'] ?? '',
              'name': transaction['destination_account']['full_name'] ?? '',
            };

            Get.to(
                  () =>
                  CreditInstallments(
                    creditInstallment: creditInstallmentMap,
                    id: widget.id.toString(),
                    pay: transaction['status'] == 'success' ? 1 : 0,
                    type: widget.type,
                    amount: amount,
                  ),
            );
          }
        } else {
          Map<String, dynamic> creditInstallmentMap = {
            'id': transaction['id'],
            'dueDate': transaction['due_date'],
            'amount': transaction['amount'],
            'status': transaction['status'],
            'installment': transaction['installment'],
            'total_installment': totalInstallment,
            'document': transaction['destination_account']['document'] ?? '',
            'name': transaction['destination_account']['full_name'] ?? '',
          };
          Get.to(
                () =>
                CreditInstallments(
                  creditInstallment: creditInstallmentMap,
                  id: widget.id.toString(),
                  pay: transaction['status'] == 'success' ? 1 : 0,
                  type: widget.type,
                  amount: amount,
                ),
          );
        }
      },
      child: Card(
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.white,
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction['status'] == 'pending'
                        ? AppLocalizations.of(context)!.group_payment
                        : AppLocalizations.of(context)!.group_paid_date,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Text(
                    dateFormat.format(DateTime.parse(transaction['due_date'])),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'R\$ ${currencyFormat.format(
                        double.parse(transaction['amount'].toString()) / 100)}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '${transaction['installment'] ?? ''} ${AppLocalizations.of(
                        context)!.off} $installment',
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}