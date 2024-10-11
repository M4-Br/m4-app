import 'dart:io';
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/controllers/onboarding/step_nine_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class OnboardingStepEightPage extends StatefulWidget {
  const OnboardingStepEightPage({super.key});

  @override
  State<OnboardingStepEightPage> createState() => _OnboardingStepEightPageState();
}

class _OnboardingStepEightPageState extends State<OnboardingStepEightPage> {
  File? _image;
  ImagePicker imagePicker = ImagePicker();
  final StepNineController _stepNineController = Get.put(StepNineController());

  Future<void> _imageFromCamera() async {
    try {
      XFile? capturedImage = await imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );

      if (!mounted) return;

      if (capturedImage != null) {
        final File imagePath = File(capturedImage.path);

        setState(() {
          _image = imagePath;
        });

        await _stepNineController.stepNine(_image!);
      } else {
        return;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  @override
  void dispose() {
    super.dispose();
    _stepNineController.dispose();
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
              AppLocalizations.of(context)!.selfie,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              AppLocalizations.of(context)!.dont_perfect,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32, bottom: 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.cut_sharp,
                    color: secondaryColor,
                    size: 32,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(AppLocalizations.of(context)!.dont_gadgets)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32, bottom: 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.filter_center_focus_outlined,
                    color: secondaryColor,
                    size: 32,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(AppLocalizations.of(context)!.focus_photo)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Row(
                children: [
                  const Icon(
                    Icons.remove_red_eye_outlined,
                    color: secondaryColor,
                    size: 32,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(AppLocalizations.of(context)!.dont_glasses)
                ],
              ),
            ),
            const Spacer(),
            Obx(
                  () => _stepNineController.isLoading.value == false
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
                    minimumSize: const Size(double.infinity, 50)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    AppLocalizations.of(context)!.understood,
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
