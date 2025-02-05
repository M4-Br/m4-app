import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:app_flutter_miban4/data/util/helpers/validators.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/controllers/login/language_controller.dart';
import 'package:app_flutter_miban4/ui/controllers/login/verify_document_controller.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_screen.dart';
import 'package:app_flutter_miban4/ui/screens/politics/privacy_policy_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_shifter_v2/mask_shifter.dart';

class LoginPage extends StatefulWidget {
  final String? lang;

  const LoginPage({super.key, this.lang});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ValidationsMixin {
  final VerifyController _verifyController = Get.put(VerifyController());
  final LanguageController _languageController = Get.put(LanguageController());

  @override
  void initState() {
    _verifyController.lastLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Obx(() => PopupMenuButton<String>(
                    color: primaryColor,
                    onSelected: (String languageCode) {
                      _languageController
                          .changeLanguage(widget.lang ?? languageCode);
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'pt',
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
                            _languageController.getLanguageFlag(
                                _languageController.lang.value!),
                            width: 25,
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
            child: SizedBox(
                width: 200,
                child: Image.asset(
                  'assets/images/ic_default_logo.png',
                  width: 120,
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 50, 32, 50),
            child: Form(
              key: _verifyController.formKey,
              child: TextFormField(
                cursorColor: Colors.white,
                controller: _verifyController.documentController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white, fontSize: 20),
                inputFormatters: [
                  MaskedTextInputFormatterShifter(
                      maskONE: "XXX.XXX.XXX-XX", maskTWO: "XX.XXX.XXX/XXXX-XX"),
                ],
                validator: isNotEmpty,
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  contentPadding: EdgeInsets.zero,
                  labelText: 'cpf'.tr,
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  hintText: '',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 0, 32, 50),
            child: Obx(
              () => _verifyController.isLoading.value == false
                  ? ElevatedButton(
                      key: const ValueKey('button'),
                      onPressed: () async {
                        _verifyController.documentInitialVerify();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side:
                              const BorderSide(color: Colors.white, width: 2),
                        ),
                        alignment: Alignment.center,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: Text(
                        'access'.tr,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 16),
                      ),
                    )
                  : const CircularProgressIndicator(
                      key: ValueKey('loading'),
                      color: Colors.white,
                    ),
            ),
          ),
          const Flexible(
              child: SizedBox(
            height: 100,
          )),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () async {
                await SharedPreferencesFunctions.saveString(
                    key: 'codeLang', value: 'codeLang'.tr);
                Get.to(() => const PrivacyPolicyPage(),
                    transition: Transition.rightToLeft);
              },
              child: Text(
                'terms'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await SharedPreferencesFunctions.saveString(
                  key: 'codeLang', value: 'codeLang'.tr);
              Get.to(() => const OnboardingPage(),
                  transition: Transition.rightToLeft);
            },
            child: Container(
              width: double.infinity,
              color: thirdColor,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'register'.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
