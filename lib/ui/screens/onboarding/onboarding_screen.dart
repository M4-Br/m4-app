import 'package:app_flutter_miban4/data/util/helpers/mask.dart';
import 'package:app_flutter_miban4/data/util/helpers/validators.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/controllers/onboarding/step_one_controller.dart';
import 'package:app_flutter_miban4/features/auth/presentation/login_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_privacy_policy_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingPage extends StatefulWidget {
  final bool? pageRead;
  final String? cpf;

  const OnboardingPage({
    super.key,
    this.pageRead = false,
    this.cpf,
  });

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final StepOneController _stepOneController = Get.put(StepOneController());

  void _navigateToPrivacyPolicy() {
    Get.to(
        () => OnboardingPrivacyPolicyPage(
              cpf: _stepOneController.cpfController.text.toString(),
            ),
        transition: Transition.rightToLeft);
  }

  @override
  void initState() {
    super.initState();
    _stepOneController.cpfController.text = widget.cpf ?? '';
    _stepOneController.check.value = widget.pageRead ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: SafeArea(
          child: IconButton(
            onPressed: () {
              Get.to(() => const LoginPage(),
                  transition: Transition.leftToRight);
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
                key: _stepOneController.formKey,
                child: TextFormField(
                  cursorColor: secondaryColor,
                  validator: (value) => Validators.combine([
                    () => Validators.isNotEmpty(value),
                  ]),
                  controller: _stepOneController.cpfController,
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
                      value: _stepOneController.check.value,
                      onChanged: (newValue) {
                        if (widget.pageRead == false) {
                          Get.to(
                              () => OnboardingPrivacyPolicyPage(
                                    cpf: _stepOneController.cpfController.text
                                        .toString(),
                                  ),
                              transition: Transition.rightToLeft);
                        } else {
                          setState(() {
                            _stepOneController.check.value = newValue!;
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
                      onPressed: () => _stepOneController.validate(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _stepOneController.check.value
                            ? secondaryColor
                            : Colors.grey,
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
}
