import 'package:app_flutter_miban4/data/api/credit/credit_mutual_request.dart';
import 'package:app_flutter_miban4/data/api/credit/credit_vote.dart';
import 'package:app_flutter_miban4/data/api/user/get_user.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/components/appBar/appBar_components.dart';
import 'package:app_flutter_miban4/ui/screens/home/credit/credit_voted.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreditMutualVote extends StatefulWidget {
  final String groupId;
  final String vote;

  const CreditMutualVote({super.key, required this.groupId, required this.vote});

  @override
  State<CreditMutualVote> createState() => _CreditMutualVoteState();
}

class _CreditMutualVoteState extends State<CreditMutualVote> {
  late Future<Map<String, dynamic>> _mutual;
  var isLoading = false.obs;
  late Future<Map<String, dynamic>> _userData;

  @override
  void initState() {
    super.initState();
    _mutual = getMutualRequest(widget.groupId);
  }

  Future<Map<String, dynamic>> _getUserData(String userId) async {
    return await getUser(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDefault(
        title: 'credit_credit'.tr.toUpperCase(),
        backPage: () => Get.back(),
      ),
      backgroundColor: primaryColor,
      body: FutureBuilder<Map<String, dynamic>>(
          future: _mutual,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        color: Color(0xFF02010f)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Text(
                          'credit_detail'
                              .tr.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              if (snapshot.hasData) {
                Map<String, dynamic> mutual = snapshot.data!;
                final currencyFormat =
                NumberFormat.currency(locale: 'pt_BR', symbol: '');

                // Use FutureBuilder to get user data after mutual data is available
                return FutureBuilder<Map<String, dynamic>>(
                  future: _getUserData(mutual['user_id'].toString()),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                color: Color(0xFF02010f)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 32),
                                child: Text(
                                  'credit_detail'
                                      .tr.toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.white,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: secondaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else if (userSnapshot.hasError) {
                      return Center(
                        child: Text('Error: ${userSnapshot.error}'),
                      );
                    } else {
                      if (userSnapshot.hasData) {
                        Map<String, dynamic> user = userSnapshot.data!;

                        return Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  color: Color(0xFF02010f)),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  child: Text(
                                    'credit_detail'
                                        .tr.toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    color: Colors.white),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text.rich(
                                          TextSpan(
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                              children: [
                                                TextSpan(
                                                    text: user['name']),
                                                TextSpan(
                                                    text: ' ${'credit_request_of'.tr} R\$${currencyFormat.format(mutual['main_amount'] / 100)}')
                                              ]),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10)),
                                            color: grey100),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'credit_group'.tr,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                  Text(
                                                    mutual['mutual']['group_account']['name'],
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'credit_payment'.tr,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                  Text(
                                                    '${mutual['mutual']['installment']}x ${'off'.tr} R\$${currencyFormat.format(mutual['installment_amount'] / 100)}',
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'credit_fees_receive'.tr,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                  Text(
                                                    'R\$${currencyFormat.format(mutual['interests'] / 100)}',
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'credit_last_payment'.tr,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                  Text(
                                                    DateFormat('dd/MM/yyyy').format(DateTime.parse(mutual['mutual']['group_account']['finish_date'])),
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      'credit_agree'.tr,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }
                  },
                );
              } else {
                return const SizedBox.shrink();
              }
            }
          }),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(32),
        color: Colors.white,
        child: Obx(() => isLoading.value == false
            ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () => _getDialog(
                  id: widget.vote,
                  vote: 'reject',
                  type: 'credit_vote_reject'.tr),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.grey),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'credit_reject'
                      .tr.toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => _getDialog(
                  id: widget.vote,
                  vote: 'accept',
                  type: 'credit_vote_accept'.tr),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: secondaryColor),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'credit_accept'
                      .tr.toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
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

  Future<void> _vote({required String id, required String vote}) async {
    try {
      isLoading(true);
      await creditVote(id, vote).then((value) {
        if (value == true) {
          Get.to(() => const CreditVoted(), transition: Transition.rightToLeft);
        }
      });
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      isLoading(false);
    }
  }

  _getDialog({required String id, required String vote, required String type}) {
    Get.defaultDialog(
      title: 'credit_vote_title_dialog'.tr,
      content: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                '${'credit_vote_dialog'.tr} $type ?',
                style: const TextStyle(color: Colors.black, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey),
                      onPressed: () => Get.back(),
                      child: Text(
                        'cancel'.tr,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: secondaryColor),
                      onPressed: () {
                        _vote(id: id, vote: vote);
                        Get.offAll(() => const CreditVoted(), transition: Transition.rightToLeft);
                      },
                      child: Text(
                        'confirm'.tr,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
