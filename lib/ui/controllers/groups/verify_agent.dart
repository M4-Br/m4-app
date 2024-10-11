import 'package:app_flutter_miban4/data/api/groups/verifyAgent.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/screens/home/groups/create_group/create_group_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class VerifyAgentController extends GetxController {
  var isLoading = false.obs;

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse('https://mibank4.com');
    if (!await launchUrl(url)) {
      throw 'Não foi possível abrir o link $url';
    }
  }

  Future<void> verify(String title, String explain, String buttonName) async {
    isLoading(true);

    try {
      final Map<String, dynamic> response = await verifyAgent();

      if (response['roles'][0]['role'] == 'agent') {
        Get.to(() => const CreateGroupName(),
            transition: Transition.rightToLeft);
      } else {
        Get.snackbar('', '',
            titleText: Text(
              title,
              style:
                  const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            messageText: Column(
              children: [
                Text(
                  explain,
                  style: const TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    height: 35,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: _launchUrl,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: secondaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50))),
                        child: Text(
                          buttonName,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                  ),
                )
              ],
            ),
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 8),
            backgroundColor: Colors.white,
            padding: const EdgeInsets.all(8));
      }
    } catch (error) {
      throw Exception(error.toString());
    } finally {
      isLoading(false);
    }
  }
}
