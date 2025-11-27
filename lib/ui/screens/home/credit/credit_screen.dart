import 'package:app_flutter_miban4/data/api/credit/user_mutuals.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/home/credit/credit_all_installments.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/groups_credit.dart';
import 'package:app_flutter_miban4/features/home/presentation/home_view_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreditScreen extends StatefulWidget {
  const CreditScreen({super.key});

  @override
  State<CreditScreen> createState() => _CreditScreenState();
}

class _CreditScreenState extends State<CreditScreen> {
  late Future<Map<String, dynamic>> _futureGroups;
  var isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    _futureGroups = getAllMutuals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarDefault(
        title: 'credit_credit'.tr.toUpperCase(),
        backPage: () => Get.off(() => const HomeViewPage(),
            transition: Transition.leftToRight),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
          future: _futureGroups,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                color: Colors.white,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: secondaryColor,
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              if (snapshot.hasData && snapshot.data!['data'].isNotEmpty) {
                List<dynamic> requestData = snapshot.data!['data'];
                int acceptedIndex = -1;

                for (int i = 0; i < requestData.length; i++) {
                  if (requestData[i]['status'] == 'active') {
                    acceptedIndex = i;
                    break;
                  }
                }

                if (acceptedIndex != -1) {
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    Get.off(
                      () => CreditAllInstallments(
                        id: requestData[acceptedIndex]['group_account_id'],
                        type: "mutual_payment",
                      ),
                      transition: Transition.rightToLeft,
                    );
                  });
                }

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
                        'assets/icons/ic_credit_blue.png',
                        height: 80,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          'credit_dont'.tr,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        'credit_enter'.tr,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => Get.off(
                                () => const GroupsScreenCredit(),
                                transition: Transition.rightToLeft),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: secondaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: Text(
                              'credit_groups'.tr.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
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
                        'assets/icons/ic_credit_blue.png',
                        height: 80,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          'credit_dont'.tr,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        'credit_enter'.tr,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => Get.off(
                                () => const GroupsScreenCredit(),
                                transition: Transition.rightToLeft),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: secondaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: Text(
                              'credit_groups'.tr.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }
          }),
    );
  }
}
