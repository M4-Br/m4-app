import 'package:app_flutter_miban4/data/api/groups/getGroups.dart';
import 'package:app_flutter_miban4/data/model/groups/groupModel.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/controllers/groups/verify_agent.dart';
import 'package:app_flutter_miban4/ui/screens/home/credit/credit_mutual_available.dart';
import 'package:app_flutter_miban4/ui/screens/home/credit/credit_screen.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/group_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GroupsScreenCredit extends StatefulWidget {
  const GroupsScreenCredit({Key? key}) : super(key: key);

  @override
  State<GroupsScreenCredit> createState() => _GroupsScreenCreditState();
}

class _GroupsScreenCreditState extends State<GroupsScreenCredit> {
  late Future<List<Group>> _futureGroups;
  var isLoading = false.obs;
  bool noGroupsAddedShown = false;
  final VerifyAgentController _controller = Get.put(VerifyAgentController());

  @override
  void initState() {
    super.initState();
    _futureGroups = getGroups(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(
        title: 'credit_credit'.tr.toUpperCase(),
        backPage: () => Get.off(() => const CreditScreen(),
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
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            if (!noGroupsAddedShown) {
              noGroupsAddedShown = true;
              return _buildNoGroupsAddedWidget();
            } else {
              return const SizedBox.shrink();
            }
          } else {
            List<Group> mutualAvailableGroups = snapshot.data!
                .where((group) => group.status == 'mutual_available')
                .toList();

            if (mutualAvailableGroups.isEmpty) {
              if (!noGroupsAddedShown) {
                noGroupsAddedShown = true;
                return _buildNoGroupsAddedWidget();
              } else {
                return const SizedBox.shrink();
              }
            }

            return ListView.builder(
              itemCount: mutualAvailableGroups.length,
              itemBuilder: (context, index) {
                Group group = mutualAvailableGroups[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8, right: 16),
                  child: GestureDetector(
                    onTap: () async {
                      String groupId = group.id.toString();
                      Get.to(() => CreditMutualAvailable(id: groupId),
                          transition: Transition.rightToLeft);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: ListTile(
                        title: Text(
                          group.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "${'group_created_in'.tr} ${DateFormat('dd/MM/yyyy').format(group.createdAt)}",
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildNoGroupsAddedWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
        ),
        Text(
          'no_groups'.tr,
          style: const TextStyle(color: Colors.black, fontSize: 20),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 45,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Get.offAll(() => const GroupsScreen(), transition: Transition.rightToLeft);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18))),
              child: Text(
                'group_add_new'.tr.toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}
