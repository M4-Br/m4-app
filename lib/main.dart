import 'package:app_flutter_miban4/data/bindings/bindings.dart';
import 'package:app_flutter_miban4/l18n/app_strings.dart';
import 'package:app_flutter_miban4/ui/controllers/login/user_controller.dart';
import 'package:app_flutter_miban4/ui/routes/app_pages.dart';
import 'package:app_flutter_miban4/ui/routes/app_routes.dart';
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
        translations: Messages(),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splash,
        getPages: AppPages.pages,
      ),
    );
  }
}
