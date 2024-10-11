import 'package:app_flutter_miban4/data/bindings/bindings.dart';
import 'package:app_flutter_miban4/ui/controllers/login/user_controller.dart';
import 'package:app_flutter_miban4/ui/routes/loginPages/login_pages.dart';
import 'package:app_flutter_miban4/ui/screens/home/home_view_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/paymentLink/paymentLink.dart';
import 'package:app_flutter_miban4/ui/screens/home/paymentLink/paymentLinkValue.dart';
import 'package:app_flutter_miban4/ui/screens/home/perfil/profile_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixAddKeys.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixAddValue.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixCodeDecode.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixCopyPaste.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixHome.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixKeyManager.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixManualKey.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixMyKeys.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixMyLimits.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixNewKey.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixQRCodeReceive.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixReceive.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixStatement.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixTransactionSuccess.dart';
import 'package:app_flutter_miban4/ui/screens/home/pix/pixWithKey.dart';
import 'package:app_flutter_miban4/ui/screens/home/qrcodeGenerator/myQRCode.dart';
import 'package:app_flutter_miban4/ui/screens/home/qrcodePayment/qrcodeConfirmPayment.dart';
import 'package:app_flutter_miban4/ui/screens/home/qrcodePayment/qrcodeReader.dart';
import 'package:app_flutter_miban4/ui/screens/home/statement/statement_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_bank_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_confirm_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_contact_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_new_contact_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_success_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_value_page.dart';
import 'package:app_flutter_miban4/ui/screens/home/transfer/transfer_voucher_page.dart';
import 'package:app_flutter_miban4/ui/screens/login/login_page.dart';
import 'package:app_flutter_miban4/ui/screens/login/password_page.dart';
import 'package:app_flutter_miban4/ui/screens/login/splash_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_approved_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_document_choose_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_email_confirm_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_in_review_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_password_register_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_privacy_policy_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_screen.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_eight_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_five_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_four_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_one_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_seven_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_six_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_three_page.dart';
import 'package:app_flutter_miban4/ui/screens/onboarding/onboarding_step_two_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(MiBan4());
}

class MiBan4 extends StatelessWidget {
  MiBan4({super.key});

  final UserController userController = UserController();

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    String? savedLanguage = box.read('language');

    Locale initialLocale = savedLanguage != null
        ? Locale(savedLanguage)
        : Get.deviceLocale!;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: GetMaterialApp(
        initialBinding: AppBindings(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: initialLocale,
        debugShowCheckedModeBanner: false,
        initialRoute: '/splashScreen',
        home: const LoginPage(),
        routes: {
          '/splashScreen': (context) => const SplashPage(),
          '/login': (context) => LoginPage(lang: savedLanguage,),
          '/password': (context) => const PasswordPage(),
          '/privacyPolicy': (context) => const OnboardingPrivacyPolicyPage(),
          '/cpfRegister': (context) => const OnboardingPage(),
          '/emailRegister': (context) => const OnboardingStepOnePage(),
          '/emailConfirm': (context) => const OnboardingEmailConfirmPage(),
          '/phoneRegister': (context) => const OnboardingStepTwoPage(),
          '/addressRegister': (context) => const OnboardingStepThreePage(),
          '/professionRegister': (context) => const OnboardingStepFourPage(),
          '/informationRegister': (context) => const OnboardingStepFivePage(),
          '/documentChoose': (context) => const OnboardingDocumentChoosePage(),
          '/documentPhoto': (context) => const OnboardingStepSixPage(),
          '/selfieDocument': (context) => const OnboardingStepSevenPage(),
          '/selfiePhoto': (context) => const OnboardingStepEightPage(),
          '/analysis': (context) => const OnboardingInReviewPage(),
          '/approved': (context) => const OnboardingApprovedPage(),
          '/passwordRegister': (context) => const OnboardingPasswordRegisterPage(),
          '/home': (context) => const HomeViewPage(),
          '/perfil': (context) => const ProfilePage(),
          '/statement': (context) => const StatementPage(),
          '/transactionContacts': (context) => const TransferContactPage(),
          '/transactionBank': (context) => const TransferBankPage(),
          '/transactionNewContact': (context) => const TransferNewContactPage(),
          '/transactionValue': (context) => const TransferValuePage(),
          '/transactionConfirm': (context) => const TransferConfirmPage(),
          '/transactionSuccess': (context) => const TransferSuccessPage(),
          '/transactionVoucher': (context) => const TransferVoucherPage(),
          '/myQRCode': (context) => const MyQRCode(),
          '/pixHome': (context) => PixHome(),
          '/pixStatement': (context) => const PixStatementPage(),
          '/pixMyKeys': (context) => const PixMyKeys(),
          '/pixKeyManager': (context) => const PixKeyManager(),
          '/pixAddKeys': (context) => const PixAddKeys(),
          '/pixNewKey': (context) => PixNewKey(),
          '/pixMyLimits': (context) => const PixMyLimits(),
          '/pixReceive': (context) => const PixReceive(),
          '/pixQRCodeReceive': (context) => PixQRCodeReceive(),
          '/pixWithKey': (context) => const PixWithKey(),
          '/pixManualKey': (context) => const PixManualKey(),
          '/pixCopyPaste': (context) => PixCopyPaste(),
          '/pixAddValue': (context) => PixAddValue(),
          '/pixCodeDecode': (context) => PixCodeDecode(),
          '/pixTransactionSuccess': (context) => PixTransactionSuccess(),
          '/paymentLinkValue': (context) => const PaymentLinkValue(),
          '/paymentLink': (context) => const PaymentLink(),
          '/qrcodeReader': (context) => QRCodeReaderScreen(),
          '/qrcodeConfirmPayment': (context) => QRCodeConfirmPayment(),
        },
      ),
    );
  }
}
