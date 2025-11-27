import 'package:app_flutter_miban4/data/util/helpers/mask.dart';
import 'package:app_flutter_miban4/data/util/helpers/shared_preferences.dart';
import 'package:app_flutter_miban4/data/util/helpers/validators.dart';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/controllers/onboarding/step_three_controller.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_one_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingStepTwoPage extends StatefulWidget {
  const OnboardingStepTwoPage({super.key});

  @override
  State<OnboardingStepTwoPage> createState() => _OnboardingStepTwoPageState();
}

class _OnboardingStepTwoPageState extends State<OnboardingStepTwoPage> {
  final _formKey = GlobalKey<FormState>();
  final _phone = TextEditingController();
  String id = '';
  final StepThreeController _stepThreeController =
      Get.put(StepThreeController());

  @override
  void initState() {
    _getId();
    super.initState();
  }

  @override
  void dispose() {
    _phone.dispose();
    _stepThreeController.dispose();
    super.dispose();
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
              Get.to(() => const OnboardingStepOnePage(),
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
            const SizedBox(height: 0),
            Text(
              'phone_register'.tr,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black54),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'for_secure_phone'.tr,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            Form(
              key: _formKey,
              child: Center(
                child: TextFormField(
                  cursorColor: secondaryColor,
                  controller: _phone,
                  keyboardType: const TextInputType.numberWithOptions(),
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                  validator: Validators.isNotEmpty,
                  maxLength: 15,
                  inputFormatters: [phoneMaskFormatter],
                  decoration: InputDecoration(
                    counterText: "",
                    isDense: true,
                    border: InputBorder.none,
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
                    labelText: 'phone'.tr,
                    labelStyle: const TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                    ),
                    hintText: '',
                  ),
                ),
              ),
            ),
            const Spacer(),
            Obx(
              () => _stepThreeController.isLoading.value == false
                  ? ElevatedButton(
                      onPressed: _stepThree,
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

  _stepThree() async {
    if (_formKey.currentState!.validate()) {
      String phoneNumber = _phone.text.replaceAll(RegExp(r'[^\d]'), '');
      String prefix = phoneNumber.substring(0, 2);
      String phone = phoneNumber.substring(2);

      try {
        await _stepThreeController.stepThree(id, prefix, phone);
      } catch (error) {
        throw Exception(error);
      }
    }
  }

  _getId() async {
    id = await SharedPreferencesFunctions.getString(key: 'id');
  }
}
