import 'package:app_flutter_miban4/data/api/privacyPolicy.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/controllers/privacyPolicy/privacy_policy_controller.dart';
import 'package:app_flutter_miban4/ui/screens/home/credit/credit_mutual_detail.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simple_html_css/simple_html_css.dart';

class OnboardingPrivacyPolicyPage extends StatefulWidget {
  final String? cpf;
  final int page;
  final String? id;
  final String? amount;

  const OnboardingPrivacyPolicyPage(
      {super.key, this.cpf, this.page = 0, this.id, this.amount});

  @override
  State<OnboardingPrivacyPolicyPage> createState() =>
      _OnboardingPrivacyPolicyPageState();
}

class _OnboardingPrivacyPolicyPageState
    extends State<OnboardingPrivacyPolicyPage> {
  late var privacy;
  bool check = false;
  final PrivacyPolicyController _privacyController =
      Get.put(PrivacyPolicyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.black,
              )),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(() {
                  return _privacyController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : FutureBuilder<Map>(
                          future: getPrivacyPolicy(),
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
                                  privacy = HTML.toRichText(
                                      context, snapshot.data!['text'],
                                      linksCallback: (link) {});

                                  return Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Container(
                                            child: privacy,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                                AppLocalizations.of(context)!
                                                    .read_policy,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                          ElevatedButton(
                                            onPressed: check
                                                ? widget.page == 0
                                                    ? () {
                                                        Get.to(
                                                            () => OnboardingPage(
                                                                  pageRead: true,
                                                                  cpf: widget.cpf,
                                                                ),
                                                            transition: Transition
                                                                .leftToRight);
                                                      }
                                                    : () {
                                                        Get.to(() =>
                                                            CreditMutualDetails(
                                                              id: widget.id!,
                                                              amount:
                                                                  widget.amount!,
                                                              pageRead: true,
                                                            ));
                                                      }
                                                : null,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: check
                                                  ? secondaryColor
                                                  : Colors.grey,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              alignment: Alignment.bottomCenter,
                                              minimumSize:
                                                  const Size(double.infinity, 50),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Text(
                                                AppLocalizations.of(context)!.next,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            }
                          });
                }),
              ],
            ),
          ),
        ));
  }
}
