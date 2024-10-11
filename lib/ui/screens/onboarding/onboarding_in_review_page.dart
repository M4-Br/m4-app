import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/screens/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class OnboardingInReviewPage extends StatefulWidget {
  const OnboardingInReviewPage({super.key});

  @override
  State<OnboardingInReviewPage> createState() => _OnboardingInReviewPageState();
}

class _OnboardingInReviewPageState extends State<OnboardingInReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset('assets/images/miban4_colored_logo.svg', width: 180,),
              Text(
                AppLocalizations.of(context)!.analysis_progress,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                AppLocalizations.of(context)!.request_sent,
                textAlign: TextAlign.center,
              ),
              Text(AppLocalizations.of(context)!.know_more),
              ElevatedButton(
                onPressed: () async {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    alignment: Alignment.bottomCenter,
                    minimumSize: const Size(200, 50)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    AppLocalizations.of(context)!.want,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.offAll(() => const LoginPage(), transition: Transition.leftToRight);
                },
                child: Text(
                  AppLocalizations.of(context)!.back_login,
                  style: const TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
