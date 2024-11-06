import 'package:app_flutter_miban4/data/util/helpers/mask.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:app_flutter_miban4/data/util/helpers/validators.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/controllers/onboarding/step_one_controller.dart';
import 'package:app_flutter_miban4/ui/screens/login/login_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_privacy_policy_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingPage extends StatefulWidget {
  final bool? pageRead;
  final String? cpf;

  const OnboardingPage({super.key, this.pageRead = false, this.cpf,});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> with ValidationsMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cpfController = TextEditingController();
  bool check = false;
  final StepOneController _stepOneController = Get.put(StepOneController());
  late String lang;

  void _navigateToPrivacyPolicy() {
    Get.to(
        () => OnboardingPrivacyPolicyPage(
              cpf: _cpfController.text.toString(),
            ),
        transition: Transition.rightToLeft);
  }

  @override
  void initState() {
    super.initState();
    _cpfController.text = widget.cpf ?? '';
    check = widget.pageRead ?? false;
  }

  @override
  void dispose() {
    _cpfController.dispose();
    _stepOneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    lang = 'codeLang'.tr;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: SafeArea(
          child: IconButton(
            onPressed: () {
              Get.to(() => const LoginPage(), transition: Transition.leftToRight);
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            Text(
              'welcome'.tr,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black54),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'insert_cpf'.tr,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const Spacer(),
            Center(
              child: Form(
                key: _formKey,
                child: TextFormField(
                  cursorColor: secondaryColor,
                  validator: (value) => combineValidators([
                    () => isNotEmpty(value),
                  ]),
                  controller: _cpfController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                  inputFormatters: [cpfMaskFormatter],
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: secondaryColor),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    contentPadding: EdgeInsets.zero,
                    labelText: "CPF",
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    hintText: '',
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black54,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      activeColor: secondaryColor,
                      value: check,
                      onChanged: (newValue) {
                        if (widget.pageRead == false) {
                          Get.to(
                              () => OnboardingPrivacyPolicyPage(
                                    cpf: _cpfController.text.toString(),
                                  ),
                              transition: Transition.rightToLeft);
                        } else {
                          setState(() {
                            check = newValue!;
                          });
                        }
                      },
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          _navigateToPrivacyPolicy();
                        },
                        child: Text(
                          'read_policy'.tr,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => _stepOneController.isLoading.value == false
                  ? ElevatedButton(
                      onPressed: () => _stepOne(check),
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
                    )
                  : const CircularProgressIndicator(
                      color: secondaryColor,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _stepOne(bool check) async {
    if (_formKey.currentState!.validate()) {
      if (check) {
        await SharedPreferencesFunctions.saveString(key: 'codeLang', value: lang);
        String document = _cpfController.text.replaceAll(".", "").replaceAll("-", "");
        try {
          await _stepOneController.verifyDocument(document, 1);
        } catch (error) {
          throw Exception(error);
        }
      }
    }
  }
}
