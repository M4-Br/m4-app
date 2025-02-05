import 'package:app_flutter_miban4/data/api/groups/getMembers.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/controllers/groups/invite_group_controller.dart';
import 'package:app_flutter_miban4/ui/screens/home/notifications/notifications_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GroupInvite extends StatefulWidget {
  final String id;
  final String invite;

  const GroupInvite({super.key, required this.id, required this.invite});

  @override
  State<GroupInvite> createState() => _GroupInviteState();
}

class _GroupInviteState extends State<GroupInvite> {
  late Future<Map<String, dynamic>> _groupDataFuture;
  bool _isActive = true;
  int _screenActivy = 0;
  final InviteGroupController _inviteGroupController =
      Get.put(InviteGroupController());

  @override
  void initState() {
    super.initState();
    _groupDataFuture = getMembers(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _groupDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: secondaryColor),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          return _buildGroupInviteScreen(snapshot.data!);
        }
      },
    );
  }

  Widget _buildGroupInviteScreen(Map<String, dynamic> data) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarDefault(
        title: data['data'][0]['group_account']['name'],
        backPage: () => Get.off(() => const Notifications(),
            transition: Transition.leftToRight),
      ),
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
                  ? _buildInformationsScreen(data)
                  : _buildMembersScreen(data),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() => _inviteGroupController.isLoading.value == false
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                        onPressed: () {
                          _invite(widget.invite, 'reject');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        child: Text(
                          'group_reject'.tr.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )),
                  ),
                  SizedBox(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                        onPressed: () {
                          _invite(widget.invite, 'accept');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: secondaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        child: Text(
                          'group_accept'.tr.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: secondaryColor,
                ),
              )),
      ),
    );
  }

  Widget _buildInformationsScreen(Map<String, dynamic> data) {
    final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: '');
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    return Padding(
      padding: const EdgeInsets.all(16),
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
                      (data['data'][0]['group_account']['installment'] *
                              data['data'][0]['group_account']
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
                  text: 'group_att'.tr,
                  style: const TextStyle(fontSize: 16),
                ),
                TextSpan(
                    text: dateFormat.format(
                      DateTime.parse(
                        data['data'][0]['group_account']['updated_at'],
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
                    'group_detail'.tr,
                    style: const TextStyle(fontSize: 18, color: Colors.black87),
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
                  data['data'][0]['group_account']['status'] == 'active'
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
                  data['data'][0]['group_account']['period'] == 'monthly'
                      ? 'group_monthly'.tr
                      : data['data'][0]['group_account']['period'] == 'biweekly'
                          ? 'group_biweekly'.tr
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
                  'group_value_per_member'.tr,
                  style: const TextStyle(fontSize: 16),
                ),
                const Spacer(),
                Text(
                  "${data['data'][0]['group_account']['installment'].toString()} x ${'off'.tr} ${currencyFormat.format(data['data'][0]['group_account']['amount_by_period'] / 100)}",
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
                  data['data'][0]['user']['name'],
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
                  'group_initial_date'.tr,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  dateFormat.format(
                    DateTime.parse(
                      data['data'][0]['group_account']['created_at'],
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
                    data['data'][0]['group_account']['finish_date'],
                  ),
                ),
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMembersScreen(Map<String, dynamic> data) {
    final members = data['data'][0]['group_account']['members'];

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

  _invite(String invite, String type) async {
    try {
      await _inviteGroupController.enterGroup(invite, type);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
