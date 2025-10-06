import 'package:app_flutter_miban4/core/config/consts/app_url.dart';

class AppEndpoints {
  static const String baseUrl = UrlConst.urlBase;

  //login
  static const String verifyAccount = '/v2/individual/';
  static const String authLogin = '/v3/auth';

  //home
  static const String fetchIcons = '/app/home_info';
}
