import 'package:app_flutter_miban4/core/config/consts/app_url.dart';

class AppEndpoints {
  static const String baseUrl = UrlConst.urlBase;

  //login
  static const String verifyAccount = '/v2/individual/';
  static const String authLogin = '/v3/auth';

  //onboarding antigo
  static const String onboardingStepOne = '/v2/register/individual';

  //onboarding novo
  static const String onboardingOne = '/v2/register/individual';
  static const String onboardingSendTokenToEmail = '/user/send_code_email';
  static const String onboardingConfirmEmail = '/user/validate_email';
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
