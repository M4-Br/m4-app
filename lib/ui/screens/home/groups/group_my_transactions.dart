import 'package:app_flutter_miban4/data/api/groups/getMyContributions.dart';
import 'package:app_flutter_miban4/data/model/groups/contributionsModel.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/group_contribution_id.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/group_data.dart';
import 'package:app_flutter_miban4/ui/screens/home/home_view_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GroupMyTransactions extends StatefulWidget {
  final Map<String, dynamic>? group;
  final int page;
  final int id;
  final String type;
  final int? amount;

  const GroupMyTransactions(
      {super.key,
      this.group,
      this.page = 0,
      required this.id,
      required this.type,
      this.amount});

  @override
  State<GroupMyTransactions> createState() => _GroupMyTransactionsState();
}

class _GroupMyTransactionsState extends State<GroupMyTransactions> {
  late Future<List<TransactionGroup>> _contributions;

  bool _isActive = true;
  int _screenActivity = 0;

  @override
  void initState() {
    super.initState();
    _loadContributions();
  }

  void _loadContributions() {
    setState(() {
      _contributions = getMyContributions(widget.id.toString(), widget.type);
    });
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: '');
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBarDefault(
        title: widget.page == 0 || widget.page == 1
            ? 'group_my_contributions'.tr.toUpperCase()
            : 'credit_credit'.tr.toUpperCase(),
        backPage: () =>
            Get.off(
                  () =>
              widget.page == 0
                  ? GroupData(
                group: widget.group,
                type: '0',
                groupID: widget.id.toString(),
              )
                  : HomeViewPage(),
              transition: Transition.leftToRight,
            ),
      ),
      body: FutureBuilder<List<TransactionGroup>>(
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
                  widget.page == 0
                      ? 'dont_have_contribution'.tr
                      : 'dont_have_credit'.tr,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            );
          } else {
            bool allPaid = snapshot.data!
                .every((transaction) => transaction.status == 'success');

            double totalAmount = snapshot.data!
                .where((transaction) => transaction.status == 'success')
                .map((transaction) => transaction.amount ?? 0)
                .fold(0, (previous, amount) => previous + amount);

            double totalOpen = snapshot.data!
                .where((transaction) => transaction.status == 'pending')
                .map((transaction) => transaction.amount ?? 0)
                .fold(0, (previous, amount) => previous + amount);

            int allInstallments = snapshot.data!.length;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.page == 0
                                ? 'group_contribution_individual'.tr
                                : 'credit_paid_installment'.tr,
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
                      Text(
                        '${'group_pending'.tr} R\$ ${currencyFormat.format(
                            totalOpen / 100)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
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
                              'group_open'.tr,
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
                              'group_paid'.tr,
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
                        snapshot.data!.where((transaction) =>
                        transaction.status == 'pending').toList(),
                        'pending',
                        totalAmount,
                        allPaid,
                      allInstallments
                    )
                        : _buildTransactionList(
                        snapshot.data!.where((transaction) =>
                        transaction.status == 'success').toList(),
                        'success',
                        totalAmount,
                        false,
                      allInstallments
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildTransactionList(List<TransactionGroup> transactions,
      String status, double amount, bool allInstalments, int allGroupInstallments) {
    int firstPendingIndex = -1;

    for (int i = 0; i < transactions.length; i++) {
      if (transactions[i].status == 'pending') {
        firstPendingIndex = i;
        break;
      }
    }

    if (allInstalments) {
      return Center(
        child: Text(
          'all_paid'.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black, fontSize: 18),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return _buildTransactionCard(
            transaction,
            amount,
            allGroupInstallments,
            index,
            firstPendingIndex,
          );
        },
      );
    }
  }

  Widget _buildTransactionCard(TransactionGroup transaction,
      double amount,
      int totalInstallment,
      int index,
      int firstPendingIndex) {
    final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: '');
    final dateFormat = DateFormat('dd/MM/yyyy');

    return InkWell(
      onTap: () async {
        if (transaction.status == 'pending' && index != firstPendingIndex) {
          Get.dialog(AlertDialog(
            title: Text(
              'message'.tr,
              textAlign: TextAlign.center,
            ),
            content: Text(
              'first_installment'.tr,
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
          Get.to(
                () =>
                Contribution(
                  id: transaction.id ?? '',
                  group: widget.group,
                  pay: transaction.status == 'success' ? 1 : 0,
                  groupID: widget.id.toString(),
                  page: widget.page,
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
                    transaction.status == 'pending'
                        ? 'group_payment'.tr
                        : 'group_paid_date'.tr,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Text(
                    dateFormat.format(
                        DateTime.parse(transaction.dueDate ?? '')),
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
                        double.parse(transaction.amount.toString()) / 100
                    )}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '${transaction.installment ?? ''} ${'off'.tr} ${totalInstallment.toString()}',
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