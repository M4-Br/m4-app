import 'package:app_flutter_miban4/core/config/app/app_colors.dart';
import 'package:app_flutter_miban4/core/config/language/controller/change_language_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageSelectorWidget extends GetView<ChangeLanguageController> {
  const LanguageSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topRight,
        child: Obx(() => PopupMenuButton<String>(
              color: primaryColor,
              onSelected: (String languageCode) {
                controller.changeLanguage(languageCode);
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'pt_BR',
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/ic_flag_pt.png',
                        width: 30,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        'PT',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'en',
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/ic_flag_en.png',
                        width: 30,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        'EN',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'es',
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/ic_flag_es.png',
                        width: 30,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        'ES',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
              icon: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/icons/ic_language.png',
                    color: Colors.white,
                    width: 40,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Image.asset(
                      controller.getLanguageFlag(
                          controller.languageController.lang.value ?? 'pt_BR'),
                      width: 25,
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
