import 'dart:io';

import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/controllers/onboarding/step_eight_controller.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_eight_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class OnboardingStepSevenPage extends StatefulWidget {
  const OnboardingStepSevenPage({super.key});

  @override
  State<OnboardingStepSevenPage> createState() => _OnboardingStepSevenPageState();
}

class _OnboardingStepSevenPageState extends State<OnboardingStepSevenPage> {
  late File _image;
  ImagePicker imagePicker = ImagePicker();
  final StepEightController _stepEightController =
      Get.put(StepEightController());

  _imageFromCamera() async {
    try {
      XFile? capturedImage =
          await imagePicker.pickImage(source: ImageSource.camera);

      if (!mounted) return;

      final File imagePath = File(capturedImage!.path);
      setState(() {
        _image = imagePath;
      });

      bool apiCallResult = await _stepEightController.stepEight(_image);

      if (apiCallResult) {
        Get.to(() => const OnboardingStepEightPage(), transition: Transition.rightToLeft);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  @override
  void dispose() {
    super.dispose();
    _stepEightController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset('assets/images/document_selfie.png'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'take_document_selfie'.tr,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: secondaryColor,
                    ),
                    child: const Center(
                      child: Text(
                        '1',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'selfie_one'.tr,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: secondaryColor,
                    ),
                    child: const Center(
                      child: Text(
                        '2',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'selfie_two'.tr,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: secondaryColor,
                    ),
                    child: const Center(
                      child: Text(
                        '3',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'selfie_three'.tr,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Obx(
              () => _stepEightController.isLoading.value == false
                  ? ElevatedButton(
                      onPressed: () async {
                        _imageFromCamera();
                      },
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
                         'understood'.tr,
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
