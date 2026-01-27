import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/profile/model/send_code_email_response.dart';

class ChangePasswordVerifyRepository {
  final _api = ApiConnection();

  Future<SendCodeEmailResponse> sendToken(int userId) async {
    return _api.post(
        endpoint: AppEndpoints.sendToken,
        body: {'user_id': userId, 'purpose': 'email'},
        fromJson: (json) => SendCodeEmailResponse.fromJson(json));
  }

  Future<SendCodeEmailResponse> validateToken(String token) async {
    return _api.post(
        endpoint: AppEndpoints.validateEmail,
        body: {'code': token},
        fromJson: (json) => SendCodeEmailResponse.fromJson(json));
  }
}
