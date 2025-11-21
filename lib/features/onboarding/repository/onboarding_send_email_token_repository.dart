import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/geral/model/message_response.dart';

class OnboardingSendEmailTokenRepository {
  Future<void> sendEmailToken(int userId) async {
    return ApiConnection().post(
        endpoint: AppEndpoints.onboardingSendTokenToEmail,
        body: {'id': userId, 'email': 'email'});
  }

  Future<MessageResponse> validateToken(String token) async {
    return ApiConnection().post(
        endpoint: AppEndpoints.onboardingConfirmEmail,
        body: {'code': token},
        fromJson: (json) => MessageResponse.fromJson(json));
  }
}
