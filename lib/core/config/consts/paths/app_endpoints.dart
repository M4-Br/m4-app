import 'package:app_flutter_miban4/core/config/consts/app_url.dart';

class AppEndpoints {
  static const String baseUrl = UrlConst.urlBase;

  //login
  static const String verifyAccount = '/v2/individual/';
  static const String authLogin = '/v3/auth';

  //notifications
  static const String notifications = '/notifications';

  //home
  static const String fetchIcons = '/app/home_info';

  //statements
  static const String statement = '/v2/statements';
  static const String statementInvoice = '/statement/ted/';
}
