import 'package:app_flutter_miban4/data/api/groups/getGroupData.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/controllers/groups/start_group_controller.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/group_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GroupPreview extends StatefulWidget {
  final String id;

  const GroupPreview({Key? key, required this.id}) : super(key: key);

  @override
  State<GroupPreview> createState() => _GroupPreviewState();
}

class _GroupPreviewState extends State<GroupPreview> {
  late Future<Map<String, dynamic>> _groupDataFuture;
  bool _isActive = true;
  int _screenActivity = 0;
  String value = '';
  String installment = '';
  String period = '';
  dynamic lastInstallment = 0;
  final StartGroupController _controller = Get.put(StartGroupController());

  @override
  void initState() {
    super.initState();
    _groupDataFuture = getGroupData(widget.id);
    getGroupStats();
  }

  void getGroupStats() async {
    value = await SharedPreferencesFunctions.getString(key: 'amount');
    installment =
        await SharedPreferencesFunctions.getString(key: 'installment');
    period = await SharedPreferencesFunctions.getString(key: 'period');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(
          title: 'group_g'.tr.toUpperCase(),
          backPage: () => Get.off(() => const GroupsScreen(),
              transition: Transition.leftToRight)),
      backgroundColor: primaryColor,
      body: FutureBuilder<Map<String, dynamic>>(
        future: _groupDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: secondaryColor),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro: ${snapshot.error}'),
            );
          } else {
            final groupResponse = snapshot.data!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                              'group_information'.tr,
                              style: TextStyle(
                                color:
                                    _isActive ? Colors.white : Colors.white54,
                              ),
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
                              topRight: Radius.circular(10),
                            ),
                            color: Color(0xFF02010f),
                          ),
                          child: Center(
                            child: Text(
                              'group_members'.tr,
                              style: TextStyle(
                                color:
                                    !_isActive ? Colors.white : Colors.white54,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: _screenActivity == 0
                        ? _buildInformationScreen(groupResponse)
                        : _buildMembersScreen(),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildInformationScreen(Map<String, dynamic> groupResponse) {
    final currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: '');
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

    // Data de início
    DateTime startDate = DateTime.parse(groupResponse['data'][0]['group_account']['created_at']);

    // Convertendo o installment para int
    int inst = int.parse(installment);

    Duration durationToAdd = Duration.zero;
    if (period == 'monthly') {
      durationToAdd = Duration(days: inst * 31); // Aproximando 1 mês como 31 dias
    } else if (period == 'biweekly') {
      durationToAdd = Duration(days: inst * 15); // Aproximando 1 quinzena como 15 dias
    } else if (period == 'bimonthly') {
      durationToAdd = Duration(days: inst * 61); // Aproximando 2 meses como 61 dias
    }

    //Data Final
    DateTime finishDate = startDate.add(durationToAdd);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'R\$',
                      style: TextStyle(
                          color: secondaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${groupResponse['data'][0]['group_account']['installment']} x ${'off'.tr}',
                      style: const TextStyle(
                          color: secondaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Text(
                currencyFormat.format(int.parse(value) / 100),
                style: const TextStyle(
                    color: secondaryColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Text.rich(
            TextSpan(
              style: const TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  text:
                      '${'group_value_per_member'.tr}: R\$',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                TextSpan(
                  text: currencyFormat.format(
                      (int.parse(value) * int.parse(installment)) / 100),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'group_periodicity'.tr,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                Text(
                  groupResponse['data'][0]['group_account']['period'] == 'monthly'
                      ? 'group_monthly'.tr
                      : groupResponse['data'][0]['group_account']['period'] == 'biweekly'
                          ? 'group_biweekly'.tr
                          : 'group_bimonthly'.tr,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'group_crated_for'.tr,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                Text(
                  groupResponse['data'].last['user']['name'] ?? '',
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'group_initial_date'.tr,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
              Text(
                dateFormat.format(startDate) ?? '',
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'group_final_date'.tr,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                Text(
                  dateFormat.format(finishDate) ?? '',
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ],
            ),
          ),
          const Spacer(),
          Obx(() => _controller.isLoading.value == false
              ? SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: _startGroup,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: secondaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      child: Text(
                        'proceed'.tr.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )),
                )
              : const Center(
                  child: CircularProgressIndicator(
                    color: secondaryColor,
                  ),
                )),
        ],
      ),
    );
  }

  Widget _buildMembersScreen() {
    return Container(
      color: Colors.white,
    );
  }

  _startGroup() async {
    try {
      await _controller.startGroup(widget.id);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
