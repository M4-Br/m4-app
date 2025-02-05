import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/groupStart.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/group_my_transactions.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/group_screen.dart';
import 'package:app_flutter_miban4/ui/screens/home/savings/savings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GroupData extends StatefulWidget {
  final Map<String, dynamic>? group;
  final String type;
  final String? groupID;
  final int? page;

  const GroupData(
      {super.key, this.group, required this.type, this.groupID, this.page = 0});

  @override
  State<GroupData> createState() => _GroupDataState();
}

class _GroupDataState extends State<GroupData> {
  bool _isActive = true;
  int _screenActivy = 0;

  final GroupStartController _groupStartController =
  Get.put(GroupStartController());

  @override
  void dispose() {
    super.dispose();
    _groupStartController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarDefault(
          title: widget.group!['data'][0]['group_account']['name'],
          backPage: () =>
          widget.page == 0
              ? Get.off(() => const GroupsScreen(),
              transition: Transition.leftToRight)
              : Get.off(() => const SavingsScreen(),
              transition: Transition.leftToRight)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: primaryColor,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _isActive = !_isActive;
                        _screenActivy = 0;
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
                          'group_information'.tr,
                          style: TextStyle(
                              color: _isActive ? Colors.white : Colors.white54),
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
                        _screenActivy = 1;
                      });
                    },
                    child: Container(
                      height: 60,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                        ),
                        color: Color(0xFF02010f),
                      ),
                      child: Center(
                        child: Text(
                          'group_members'.tr,
                          style: TextStyle(
                              color:
                              !_isActive ? Colors.white : Colors.white54),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: _screenActivy == 0
                  ? _buildInformationsScreen()
                  : _buildMembersScreen(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Get.to(
                      () =>
                      GroupMyTransactions(
                        group: widget.group,
                        id: int.parse(widget.groupID.toString()),
                        type: 'group_account_payment',
                        page: int.parse(widget.page.toString()),
                      ),
                  transition: Transition.rightToLeft);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: secondaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Text(
              'group_my_contributions'.tr
                  .toUpperCase(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInformationsScreen() {
    final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: '');
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Text(
              'group_contribution'.tr,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text.rich(
              TextSpan(
                style: const TextStyle(color: secondaryColor),
                children: [
                  const TextSpan(
                      text: 'R\$',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: currencyFormat.format(
                        (widget.group!['data'][0]['group_account']
                        ['installment'] *
                            widget.group!['data'][0]['group_account']
                            ['amount_by_period']) /
                            100,
                      ),
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${'group_att'.tr}  ',
                    style: const TextStyle(fontSize: 16),
                  ),
                  TextSpan(
                      text: dateFormat.format(
                        DateTime.parse(
                          widget.group!['data'][0]['group_account']
                          ['updated_at'],
                        ),
                      ),
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 16),
              child: Row(
                children: [
                  Expanded(
                      child: Divider(
                        color: Colors.grey.withAlpha(90),
                        thickness: 2,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'group_details'.tr,
                      style:
                      const TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey.withAlpha(90),
                      thickness: 2,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Status',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    widget.group!['data'][0]['group_account']['status'] ==
                        'active'
                        ? 'active'.tr
                        : widget.group!['data'][0]['group_account']['status'] ==
                        'pendent_of_activation'
                        ? 'pending'.tr
                        : widget.group!['data'][0]['group_account']
                    ['status'] ==
                        'mutual_available'
                        ? 'active'.tr
                        : 'inactive'.tr,
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'group_periodicity'.tr,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    widget.group!['data'][0]['group_account']['period'] ==
                        'monthly'
                        ? 'group_monthly'.tr
                        : widget.group!['data'][0]['group_account']['period'] ==
                        'weekly'
                        ? 'group_weekly'.tr
                        : 'group_bimonthly'.tr,
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'group_member_value'.tr,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  Text(
                    "${widget.group!['data'][0]['group_account']['installment']
                        .toString()} x ${'off'.tr} ${currencyFormat.format(
                        widget
                            .group!['data'][0]['group_account']['amount_by_period'] /
                            100)}",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'group_crated_for'.tr,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    widget.group!['data'][0]['user']['name'].length > 30
                        ? widget.group!['data'][0]['user']['name'].substring(
                        0, 30) + '\n' +
                        widget.group!['data'][0]['user']['name'].substring(30)
                        : widget.group!['data'][0]['user']['name'],
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.right,
                    softWrap: true,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'group_initial_date'.tr,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    dateFormat.format(
                      DateTime.parse(
                        widget.group!['data'][0]['group_account']['created_at'],
                      ),
                    ),
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'group_final_date'.tr,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  dateFormat.format(
                    DateTime.parse(
                      widget.group!['data'][0]['group_account']['finish_date'],
                    ),
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 16),
              child: Row(
                children: [
                  Expanded(
                      child: Divider(
                        color: Colors.grey.withAlpha(90),
                        thickness: 2,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'credit_details'.tr,
                      style:
                      const TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey.withAlpha(90),
                      thickness: 2,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'group_installments'.tr,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    (widget.group != null &&
                        widget.group!.containsKey('data') &&
                        widget.group!['data'] is List &&
                        widget.group!['data'].isNotEmpty &&
                        widget.group!['data'][0].containsKey('group_account') &&
                        widget.group!['data'][0]['group_account'].containsKey(
                            'mutual') &&
                        widget.group!['data'][0]['group_account']['mutual']
                            .containsKey('installment') &&
                        widget
                            .group!['data'][0]['group_account']['mutual']['installment'] !=
                            null)
                        ? widget
                        .group!['data'][0]['group_account']['mutual']['installment']
                        .toString()
                        : '',
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'group_priority'.tr,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    (widget.group != null &&
                        widget.group!.containsKey('data') &&
                        widget.group!['data'] is List &&
                        widget.group!['data'].isNotEmpty &&
                        widget.group!['data'][0].containsKey('group_account') &&
                        widget.group!['data'][0]['group_account'].containsKey(
                            'mutual') &&
                        widget.group!['data'][0]['group_account']['mutual']
                            .containsKey('priority') &&
                        widget
                            .group!['data'][0]['group_account']['mutual']['priority'] !=
                            null)
                        ? (widget
                        .group!['data'][0]['group_account']['mutual']['priority'] ==
                        'repairs'
                        ? 'repairs'.tr
                        : widget
                        .group!['data'][0]['group_account']['mutual']['priority'] ==
                        'revenue_generation'
                        ? 'revenue_generation'.tr
                        : widget
                        .group!['data'][0]['group_account']['mutual']['priority'] ==
                        'health'
                        ? 'health'.tr
                        : widget
                        .group!['data'][0]['group_account']['mutual']['priority'] ==
                        'emergency_money'
                        ? 'emergency_money'.tr
                        : widget
                        .group!['data'][0]['group_account']['mutual']['priority'] ==
                        'purchases'
                        ? 'purchases'.tr
                        : widget
                        .group!['data'][0]['group_account']['mutual']['priority']
                        .toString())
                        : '',
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'credit_fee_value'.tr,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    (widget.group != null &&
                        widget.group!.containsKey('data') &&
                        widget.group!['data'] is List &&
                        widget.group!['data'].isNotEmpty &&
                        widget.group!['data'][0].containsKey('group_account') &&
                        widget.group!['data'][0]['group_account'].containsKey(
                            'mutual') &&
                        widget.group!['data'][0]['group_account']['mutual']
                            .containsKey('fee') &&
                        widget
                            .group!['data'][0]['group_account']['mutual']['fee'] !=
                            null)
                        ? '${currencyFormat.format(double.parse(widget
                        .group!['data'][0]['group_account']['mutual']['fee']
                        .toString()) / 100)} %'
                        : '',
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'group_billing'.tr,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    (widget.group != null &&
                        widget.group!.containsKey('data') &&
                        widget.group!['data'] is List &&
                        widget.group!['data'].isNotEmpty &&
                        widget.group!['data'][0].containsKey('group_account') &&
                        widget.group!['data'][0]['group_account'].containsKey(
                            'mutual') &&
                        widget.group!['data'][0]['group_account']['mutual']
                            .containsKey('charge') &&
                        widget
                            .group!['data'][0]['group_account']['mutual']['charge'] !=
                            null)
                        ? (widget
                        .group!['data'][0]['group_account']['mutual']['charge'] ==
                        true
                        ? 'yes'.tr
                        : 'no'.tr)
                        : '',
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMembersScreen() {
    final members = widget.group!['data'][0]['group_account']['members'];

    if (members.isEmpty) {
      return const Center(
        child: Text(
          'No members in this group.',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: members.length,
        itemBuilder: (context, index) {
          var member = members[index];
          return Column(
            children: [
              GestureDetector(
                onTap: () {},
                child: ListTile(
                  title: Text(member['name']),
                ),
              ),
              const Divider(color: Colors.grey),
            ],
          );
        },
      ),
    );
  }
}
