import 'package:app_flutter_miban4/ui/colors/app_colors.dart';
import 'package:app_flutter_miban4/ui/screens/login/login_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_password_register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingApprovedPage extends StatefulWidget {
  const OnboardingApprovedPage({super.key});

  @override
  State<OnboardingApprovedPage> createState() => _OnboardingApprovedPageState();
}

class _OnboardingApprovedPageState extends State<OnboardingApprovedPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset('assets/images/miban4_colored_logo.svg', width: 180,),
              Text(
                AppLocalizations.of(context)!.approved,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                AppLocalizations.of(context)!.need_create_password,
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                onPressed: () async {
                  Get.to(() => OnboardingPasswordRegisterPage(), transition: Transition.rightToLeft);
                },
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
                    AppLocalizations.of(context)!.create_password,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.off(() => const LoginPage(), transition: Transition.leftToRight);
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
