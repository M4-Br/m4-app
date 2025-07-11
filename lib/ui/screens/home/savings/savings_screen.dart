import 'package:app_flutter_miban4/data/api/groups/getGroups.dart';
import 'package:app_flutter_miban4/data/api/groups/getMembers.dart';
import 'package:app_flutter_miban4/data/model/groups/groupModel.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/group_data.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/group_screen.dart';
import 'package:app_flutter_miban4/ui/screens/home/home_view_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SavingsScreen extends StatefulWidget {
  const SavingsScreen({Key? key}) : super(key: key);

  @override
  State<SavingsScreen> createState() => _SavingsScreenState();
}

class _SavingsScreenState extends State<SavingsScreen> {
  late Future<List<Group>> _futureGroups;
  var isLoading = false.obs;
  bool noGroupsAddedShown = false;

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
        title: 'savings'.tr.toUpperCase(),
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
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            if (!noGroupsAddedShown) {
              // Verifica se o texto 'Nenhum grupo criado' já foi exibido
              noGroupsAddedShown =
                  true; // Define como verdadeiro para que o texto não seja exibido novamente
              return _buildNoGroupsAddedWidget(); // Exibe o widget quando não há grupos adicionados
            } else {
              return const SizedBox
                  .shrink(); // Retorna um widget vazio para evitar a repetição do texto
            }
          } else {
            // Filtrar os grupos com status 'mutual_available'
            List<Group> mutualAvailableGroups = snapshot.data!
                .where((group) => group.status == 'active')
                .toList();

            // Se não houver grupos 'mutual_available', exibe o texto 'Nenhum grupo criado'
            if (mutualAvailableGroups.isEmpty) {
              if (!noGroupsAddedShown) {
                noGroupsAddedShown = true;
                return _buildNoGroupsAddedWidget();
              } else {
                return const SizedBox.shrink();
              }
            }

            // Se houver grupos 'mutual_available', exibe-os
            return ListView.builder(
              itemCount: mutualAvailableGroups.length,
              itemBuilder: (context, index) {
                Group group = mutualAvailableGroups[index];
                final currencyFormat =
                    NumberFormat.currency(locale: 'pt_BR', symbol: '');
                return Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8, right: 16),
                  child: GestureDetector(
                    onTap: () async {
                      String groupId = group.id.toString();
                      Map<String, dynamic> groupMembers =
                          await getMembers(groupId);
                      Get.to(
                          () => GroupData(
                                type: '1',
                                group: groupMembers,
                                groupID: groupId,
                                page: 1,
                              ),
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
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${'savings_created_at'.tr} ${DateFormat('dd/MM/yyyy').format(group.createdAt)}",
                            ),
                            Text(
                                '${'savings_savings'.tr} ${currencyFormat.format((group.amountContributions)! / 100)}')
                          ],
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
        Center(
          child: Text(
            'no_groups'.tr,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () => Get.to(() => const GroupsScreen(),
                transition: Transition.rightToLeft),
            style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18))),
            child: Text(
              'groups_add'.tr,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
