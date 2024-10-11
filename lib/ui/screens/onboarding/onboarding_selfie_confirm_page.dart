import 'dart:convert';

import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_in_review_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingSelfieConfirmPage extends StatefulWidget {
  final Map<String, dynamic>? result;

  const OnboardingSelfieConfirmPage({super.key, required this.result});

  @override
  State<OnboardingSelfieConfirmPage> createState() => _OnboardingSelfieConfirmPageState();
}

class _OnboardingSelfieConfirmPageState extends State<OnboardingSelfieConfirmPage> {
  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64Decode(widget.result!['base64']);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Image.memory(bytes)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                AppLocalizations.of(context)!.onboarding_confirm_selfie,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style:
                ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: Text(
                  AppLocalizations.of(context)!.onboarding_confirm_again.toUpperCase(),
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () => Get.offAll(() => const OnboardingInReviewPage(),
                    transition: Transition.rightToLeft),
                style:
                    ElevatedButton.styleFrom(backgroundColor: secondaryColor),
                child: Text(
                  AppLocalizations.of(context)!.onboarding_confirm_cool.toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
