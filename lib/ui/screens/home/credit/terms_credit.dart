import 'package:app_flutter_miban4/data/api/credit/getTerms.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/controllers/credit/terms_controller.dart';
import 'package:app_flutter_miban4/ui/screens/home/credit/credit_mutual_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreditTerms extends StatefulWidget {
  String? id;
  String? amount;

  CreditTerms({super.key, this.id, this.amount});

  @override
  State<CreditTerms> createState() => _CreditTermsState();
}

class _CreditTermsState extends State<CreditTerms> {
  late String terms;
  bool check = false;

  final CreditTermsController _controller = Get.put(CreditTermsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() {
                return _controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : FutureBuilder<Map>(
                        future: getCreditTerms(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                              return const Center(
                                  child: CircularProgressIndicator());
                            default:
                              if (snapshot.hasError) {
                                return const Center(
                                  child: Text("Erro ao carregar.."),
                                );
                              } else {
                                terms = Bidi.stripHtmlIfNeeded(
                                    snapshot.data!['content']);

                                return Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'terms_credit'.tr,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                            textAlign: TextAlign.center,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 18),
                                            child: Text(
                                              'terms_credit_read'.tr,
                                              style:
                                                  const TextStyle(fontSize: 16),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        terms,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Checkbox(
                                                activeColor: secondaryColor,
                                                value: check,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    check = newValue!;
                                                  });
                                                },
                                              ),
                                              Text(
                                                'terms_read'.tr,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                          }
                        });
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            Get.to(() => CreditMutualDetails(
                  id: widget.id!,
                  amount: widget.amount!,
                  pageRead: true,
                ));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: check ? secondaryColor : Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            alignment: Alignment.bottomCenter,
            minimumSize: const Size(double.infinity, 50),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'next'.tr,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
