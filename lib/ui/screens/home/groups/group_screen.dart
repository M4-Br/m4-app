import 'package:app_flutter_miban4/data/api/groups/getGroups.dart';
import 'package:app_flutter_miban4/data/api/groups/getMembers.dart';
import 'package:app_flutter_miban4/data/model/groups/groupModel.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/controllers/groups/verify_agent.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/group_data.dart';
import 'package:app_flutter_miban4/features/home/presentation/home_view_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  late Future<List<Group>> _futureGroups;
  var isLoading = false.obs;
  final VerifyAgentController _agentController =
      Get.put(VerifyAgentController());

  @override
  void initState() {
    super.initState();
    _futureGroups = getGroups(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarDefault(
        title: 'groups_screen'.tr,
        backPage: () => Get.off(() => const HomeViewPage(),
            transition: Transition.leftToRight),
      ),
      body: FutureBuilder<List<Group>>(
        future: _futureGroups,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: secondaryColor,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  Image.asset(
                    'assets/icons/ic_group_blue.png',
                    height: 80,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'group_no_group'.tr,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    'group_no_group_detail'.tr,
                    style: const TextStyle(color: Colors.grey, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else {
            // Organize groups by status
            Map<String, List<Group>> groupedByStatus = {};
            for (Group group in snapshot.data!) {
              String status = group.status!;
              if (!groupedByStatus.containsKey(status)) {
                groupedByStatus[status] = [];
              }
              groupedByStatus[status]!.add(group);
            }

            return ListView(
              children: groupedByStatus.keys.map((status) {
                if (status == 'active' || status == 'canceled') {
                  List<Group> groupsForStatus = groupedByStatus[status]!;

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16, left: 16),
                        child: Text(
                          getStatusText(status),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: groupsForStatus.length,
                        itemBuilder: (context, index) {
                          Group group = groupsForStatus[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 16, top: 8, right: 16),
                            child: GestureDetector(
                              onTap: () async {
                                try {
                                  String groupId = group.id.toString();
                                  Map<String, dynamic> groupMembers =
                                      await getMembers(groupId);
                                  Get.to(
                                      () => GroupData(
                                            group: groupMembers,
                                            type: '0',
                                            groupID: groupId,
                                          ),
                                      transition: Transition.rightToLeft);
                                } catch (e) {
                                  throw Exception(e.toString());
                                }
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: ListTile(
                                  title: Text(
                                    group.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    "${'group_created_in'.tr} ${DateFormat('dd/MM/yyyy').format(group.createdAt)}",
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }).toList(),
            );
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() => _agentController.isLoading.value == false
            ? SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _verifyAgent(
                        title: 'facilitator'.tr,
                        explain: 'facilitator_explain'.tr,
                        buttonName: 'site'.tr);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24))),
                  child: Text(
                    'group_add_new'.tr.toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                  color: secondaryColor,
                ),
              )),
      ),
    );
  }

  String getStatusText(String status) {
    switch (status) {
      case 'active':
        return 'group_active'.tr;
      case 'canceled':
        return 'group_cancelled'.tr;
      case 'pendent_of_invites':
        return 'Pendente de Convite';
      case 'mutual_available':
        return 'group_mutual_available'.tr;
      case 'pendent_of_activation':
        return 'group_activation_pending'.tr;
      default:
        return 'Inativo';
    }
  }

  _verifyAgent(
      {required String title,
      required String explain,
      required String buttonName}) async {
    try {
      await _agentController.verify(title, explain, buttonName);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
