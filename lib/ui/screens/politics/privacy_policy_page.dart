import 'package:app_flutter_miban4/data/api/privacyPolicy.dart';
import 'package:app_flutter_miban4/ui/controllers/privacyPolicy/privacy_policy_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_html_css/simple_html_css.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    late var privacy;
    final PrivacyPolicyController privacyController =
        Get.put(PrivacyPolicyController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Obx(
                () {
                  return privacyController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : Expanded(
                          child: FutureBuilder<Map>(
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

                                    return SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Container(
                                        child: privacy,
                                      ),
                                    );
                                  }
                              }
                            },
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
