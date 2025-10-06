import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:app_flutter_miban4/data/util/helpers/validators.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/controllers/onboarding/step_two_controller.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingStepOnePage extends StatefulWidget {
  final String? id;
  final String? lang;

  const OnboardingStepOnePage({super.key, this.id, this.lang});

  @override
  State<OnboardingStepOnePage> createState() => _OnboardingStepOnePageState();
}

class _OnboardingStepOnePageState extends State<OnboardingStepOnePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _nick = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _promotional = TextEditingController();
  final StepTwoController _stepTwoController = Get.put(StepTwoController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _nick.dispose();
    _email.dispose();
    _promotional.dispose();
    _stepTwoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: SafeArea(
          child: IconButton(
            onPressed: () {
              Get.to(() => const OnboardingPage(),
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
            const SizedBox(height: 20),
            Text(
              'register_init'.tr,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black54),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'informations_continue'.tr,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 50),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      cursorColor: secondaryColor,
                      controller: _name,
                      keyboardType: TextInputType.text,
                      validator: (value) => Validators.combine([
                        () => Validators.isNotEmpty(value),
                        () => Validators.hasMinChars(value, 6),
                      ]),
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                      decoration: InputDecoration(
                        prefixText: "",
                        isDense: true,
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: secondaryColor),
                        ),
                        errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        contentPadding: EdgeInsets.zero,
                        labelText: 'full_name'.tr,
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                        ),
                        hintText: '',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      cursorColor: secondaryColor,
                      controller: _nick,
                      keyboardType: TextInputType.text,
                      validator: Validators.isNotEmpty,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                      decoration: InputDecoration(
                        prefixText: "@",
                        isDense: true,
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: secondaryColor),
                        ),
                        errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        contentPadding: EdgeInsets.zero,
                        labelText: 'nickname'.tr,
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                        ),
                        hintText: '',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      cursorColor: secondaryColor,
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => Validators.combine([
                        () =>
                            Validators.isNotEmpty(value, 'validator_empty'.tr),
                        () => Validators.isValidEmail(
                            value, 'validator_valid_email'.tr)
                      ]),
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                      decoration: const InputDecoration(
                        isDense: true,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
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
                        labelText: "Email",
                        labelStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                        ),
                        hintText: '',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      cursorColor: secondaryColor,
                      controller: _promotional,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                      decoration: InputDecoration(
                        isDense: true,
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: secondaryColor),
                        ),
                        errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        contentPadding: EdgeInsets.zero,
                        labelText: 'promotional_code'.tr,
                        labelStyle: const TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                        ),
                        hintText: '',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Obx(
              () => _stepTwoController.isLoading.value == false
                  ? ElevatedButton(
                      onPressed: _verifyEmail,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor,
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

  Future<void> _verifyEmail() async {
    if (_formKey.currentState!.validate()) {
      String name = _name.text.toString();
      String username = _nick.text.toString();
      String email = _email.text.toString();
      String? promoCode = _promotional.text.toString();
      String id = await SharedPreferencesFunctions.getString(key: 'id');

      try {
        await _stepTwoController.stepTwo(id, name, username, email, promoCode);
      } catch (error) {
        throw Exception(error);
      }
    }
  }
}
