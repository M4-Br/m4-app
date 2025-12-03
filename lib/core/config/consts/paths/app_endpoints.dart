import 'package:app_flutter_miban4/core/helpers/url_helper.dart';

class AppEndpoints {
  static String baseUrl = UrlHelper.url;

  //login
  static const String verifyAccount = '/v2/individual/';
  static const String authLogin = '/v3/auth';

  //onboarding
  static const String onboardingDocument = '/v2/register/individual';
  static const String onboardingBasicData = '/v2/register/individual/step1';
  static const String onboardingConfirmEmail =
      '/v2/register/individual/step1/validate';
  static const onboardingPhone = '/v2/register/individual/step2';
  static const onboardingPhoneConfirm =
      '/v2/register/individual/step2/validate';
  static const String onboardingRegisterPassword =
      '/v2/register/individual/step9';

  //notifications
  static const String notifications = '/notifications';

  //balance
  static const String balance = '/account/balance';

  //home
  static const String fetchIcons = '/app/home_info';

  //profile
  static const String userPlans = '/plans/contract/';
  static const String userParams = '/payment_capacity/params';
  static const String userCapacity = '/payment_capacity/';

  //statements
  static const String statement = '/v2/statements';
  static const String statementInvoice = '/statement/ted/';

  //payment link
  static const String paymentLink = '/transactions/link/create';

  //pix
  static const String pixKeyManager = '/pix/dict';
  static const String pixLimits = '/pix/limits';
  static const String pixReceive = '/pix/code/static';
  static const String pixValidateKey = '/pix/dict/validate';
  static const String pixTransfer = '/pix/transfers';
  static const String pixScheduled = '/pix/scheduled';
  static const String pixCodeDecode = '/pix/code/decode';
}
