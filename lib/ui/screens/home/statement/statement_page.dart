import 'package:app_flutter_miban4/core/config/auth/controller/user_controller.dart';
import 'package:app_flutter_miban4/core/config/auth/model/user.dart';
import 'package:app_flutter_miban4/data/api/statement/statementAuth.dart';
import 'package:app_flutter_miban4/data/model/statement/statementModel.dart';
import 'package:app_flutter_miban4/data/model/userData/user.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/components/statement/statement_balance.dart';
import 'package:app_flutter_miban4/ui/screens/home/statement/statement_voucher_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class StatementPage extends StatefulWidget {
  const StatementPage({
    super.key,
  });

  @override
  State<StatementPage> createState() => _StatementPageState();
}

class _StatementPageState extends State<StatementPage> {
  int selectedMonth = DateTime.now().month;
  String startDate = '';
  String endDate = '';
  DateTime? start;
  DateTime? end;

  final UserController _userController = Get.put(UserController());

  bool _isActive = true;
  int _screenActivy = 0;

  // Variável de controle para forçar a reconstrução do FutureBuilder
  Key _futureKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('pt_BR', null);
    selectedMonth = DateTime.now().month;
    updateDates();
  }

  @override
  Widget build(BuildContext context) {
    User? userData = _userController.user.value;

    String formatAmount(String amount) {
      if (amount.contains('.')) {
        double decimalAmount = double.parse(amount);
        int cents = (decimalAmount * 100).toInt();
        return (cents / 100).toStringAsFixed(2).replaceAll('.', ',');
      } else {
        return (double.parse(amount) / 100)
            .toStringAsFixed(2)
            .replaceAll('.', ',');
      }
    }

    return Scaffold(
      appBar: AppBarDefault(
        title: 'statement'.tr,
        hasIcon: false,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          StatementBalance(
            balanceType: _screenActivy,
          ),
          Container(
            color: primaryColor,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (_screenActivy == 0) return;
                      setState(() {
                        _isActive = !_isActive;
                        _screenActivy = 0;
                        _futureKey = UniqueKey();
                      });
                    },
                    child: Container(
                      height: 50,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                        ),
                        color: Color(0xFF02010f),
                      ),
                      child: Center(
                        child: Text(
                          'transactional_statement'.tr,
                          style: TextStyle(
                              color: _isActive ? Colors.white : Colors.white54,
                              fontSize: 18),
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
                      if (_screenActivy == 1) return;
                      setState(() {
                        _isActive = !_isActive;
                        _screenActivy = 1;
                        _futureKey = UniqueKey();
                      });
                    },
                    child: Container(
                      height: 50,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                        ),
                        color: Color(0xFF02010f),
                      ),
                      child: Center(
                        child: Text(
                          'savings_statement'.tr,
                          style: TextStyle(
                              color: !_isActive ? Colors.white : Colors.white54,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
                    child: Icon(
                      Icons.calendar_today_outlined,
                      color: secondaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.black54,
          ),
          Flexible(
            child: FutureBuilder<StatementModel>(
              key: _futureKey,
              future: fetchStatement(
                  startDate.toString(),
                  endDate.toString(),
                  _screenActivy == 0
                      ? userData!.user.aliasAccount!.accountId
                      : userData!.user.aliasAccount!.economyAccountId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(_screenActivy == 0
                        ? userData.user.aliasAccount!.accountId.isNotEmpty &&
                                userData.user.aliasAccount!.accountId != ''
                            ? 'statement_no_data'.tr
                            : 'account_waiting'.tr
                        : userData.user.aliasAccount!.economyAccountId
                                    .isNotEmpty &&
                                userData.user.aliasAccount!.economyAccountId !=
                                    ''
                            ? 'statement_no_data'.tr
                            : 'account_savings_waiting'.tr),
                  );
                } else {
                  StatementModel statement = snapshot.data!;

                  if (statement.statements!.isEmpty) {
                    return Center(
                      child: Text('statement_noData'.tr),
                    );
                  }

                  return ListView.builder(
                    itemCount: statement.statements!.length * 2 - 1,
                    itemBuilder: (context, index) {
                      if (index.isOdd) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: grey120,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Container(
                                  height: 15,
                                  width: 2,
                                  color: grey120,
                                ),
                              )
                            ],
                          ),
                        );
                      }
                      var extratoIndex = index ~/ 2;
                      var extrato = statement.statements![extratoIndex];
                      return GestureDetector(
                        onTap: () {
                          Get.to(
                              () => StatementVoucherScreen(
                                    status: '',
                                    amount: '',
                                    beneficiary: '',
                                    documentBeneficiary: '',
                                    bank: '',
                                    origin: '',
                                    originDocument: '',
                                    originBank: '',
                                    id: extrato.idStatement.toString(),
                                    type: extrato.type == "pix" &&
                                            extrato.creditFlag == 0
                                        ? 'pix_send'.tr
                                        : extrato.typeDescription.toString() ==
                                                "Débito Transferência"
                                            ? 'transfer_send'.tr
                                            : extrato.typeDescription
                                                        .toString() ==
                                                    "Crédito Transferência"
                                                ? 'transfer_received'.tr
                                                : extrato.typeDescription
                                                            .toString() ==
                                                        'Tar. Cobr.'
                                                    ? "TED"
                                                    : extrato.type == "ted"
                                                        ? "TED"
                                                        : 'pix_received'.tr,
                                    date: extrato.dateTransaction.toString(),
                                  ),
                              transition: Transition.rightToLeft);
                        },
                        child: ListTile(
                          title: Text(extrato.dayTransaction.toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(extrato.description.toString()),
                          trailing: Text(
                            '${extrato.creditFlag == 0 ? '-' : '+'} R\$ ${formatAmount(extrato.amount.toString())}',
                            style: TextStyle(
                                color: extrato.creditFlag == 0
                                    ? Colors.red
                                    : primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
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
