
import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_six_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class OnboardingDocumentChoosePage extends StatefulWidget {
  const OnboardingDocumentChoosePage({super.key});

  @override
  State<OnboardingDocumentChoosePage> createState() => _OnboardingDocumentChoosePageState();
}

class _OnboardingDocumentChoosePageState extends State<OnboardingDocumentChoosePage> {
  String _selectedOption = '';
  String _documentChoose = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.choose_document,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            const Divider(height: 1, color: Colors.black38,),
            ListTile(
              title: const Text('RG', style: TextStyle(fontWeight: FontWeight.bold),),
              leading: Radio(
                value: 'RG',
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value!;
                    _documentChoose = 'rg';
                  });
                },
              ),
            ),
            const Divider(height: 1, color: Colors.black38,),
            ListTile(
              title: const Text('CNH', style: TextStyle(fontWeight: FontWeight.bold),),
              leading: Radio(
                value: 'CNH',
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value!;
                    _documentChoose = 'cnh';
                  });
                },
              ),
            ),
            const Divider(height: 1, color: Colors.black38,),
            const Spacer(),
            ElevatedButton(
              onPressed: _documentPhoto,
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
                  AppLocalizations.of(context)!.next,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _documentPhoto() async {
    if (_documentChoose.isNotEmpty) {
      Get.to(() => OnboardingStepSixPage(document: _documentChoose), transition: Transition.rightToLeft);
    } else {
      null;
    }
  }
}
