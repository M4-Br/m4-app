import 'dart:io';

import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/controllers/onboarding/step_seven_controller.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_seven_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class OnboardingStepSixPage extends StatefulWidget {
  final String? document;

  const OnboardingStepSixPage({super.key, this.document});

  @override
  State<OnboardingStepSixPage> createState() => _OnboardingStepSixPageState();
}

class _OnboardingStepSixPageState extends State<OnboardingStepSixPage> {
  bool backPhotoSend = false;
  bool frontPhotoSend = false;
  final StepSevenController _stepSevenController = Get.put(StepSevenController());

  File? _imageFront;
  File? _imageBack;

  ImagePicker imagePicker = ImagePicker();

  Future<void> _imageFromCamera(String type, String document) async {
    try {
      XFile? capturedImage = await imagePicker.pickImage(source: ImageSource.camera);
      if (capturedImage != null) {
        final File imagePath = File(capturedImage.path);
        print('Captured image path: ${imagePath.path}');

        setState(() {
          if (type == 'front') {
            _imageFront = imagePath;
          } else if (type == 'back') {
            _imageBack = imagePath;
          }
        });

        bool response = await _stepSevenController.stepSeven(type, document, imagePath);
        print('Response from server: $response');

        if (response && type == 'front') {
          setState(() {
            frontPhotoSend = true;
          });
        } else if (response && type == 'back') {
          setState(() {
            backPhotoSend = true;
          });
        }
      } else {
        print('No image captured');
      }
    } catch (e) {
      print('Error capturing image: $e');
    }
  }


  @override
  void dispose() {
    super.dispose();
    _stepSevenController.dispose();
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
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.every_ok,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black54),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                AppLocalizations.of(context)!.plastic,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            const Divider(height: 1),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(AppLocalizations.of(context)!.front_photo),
                    const Spacer(),
                    if (frontPhotoSend)
                      const Icon(Icons.check, color: Colors.green),
                    if (!frontPhotoSend)
                      const Icon(Icons.keyboard_arrow_right_outlined),
                  ],
                ),
              ),
              onTap: () {
                if (!frontPhotoSend) {
                  _imageFromCamera('front', widget.document!);
                }
              },
            ),
            const Divider(),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(AppLocalizations.of(context)!.back_photo),
                    const Spacer(),
                    if (backPhotoSend)
                      const Icon(Icons.check, color: Colors.green),
                    if (!backPhotoSend)
                      const Icon(Icons.keyboard_arrow_right_outlined),
                  ],
                ),
              ),
              onTap: () {
                if (!backPhotoSend) {
                  _imageFromCamera('back', widget.document!);
                }
              },
            ),
            const Divider(),
            const Spacer(),
            Obx(
                  () => _stepSevenController.isLoading.value == false
                  ? ElevatedButton(
                onPressed: backPhotoSend && frontPhotoSend
                    ? () {
                  Get.to(() => const OnboardingStepSevenPage(),
                      transition: Transition.rightToLeft);
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: backPhotoSend && frontPhotoSend
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
                    AppLocalizations.of(context)!.next,
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
