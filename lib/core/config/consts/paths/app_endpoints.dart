import 'package:app_flutter_miban4/core/config/consts/app_url.dart';

class AppEndpoints {
  static const String baseUrl = UrlConst.urlBase;

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
}
