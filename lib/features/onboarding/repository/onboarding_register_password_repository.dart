import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_register_password_response.dart';

class OnboardingRegisterPasswordRepository {
  Future<OnboardingRegisterPasswordResponse> registerPassword(
      int id, int password) async {
    return await ApiConnection().post(
        endpoint: AppEndpoints.onboardingRegisterPassword,
        body: {
          'individual_id': id,
          'password': password,
          'confirm_password': password
        },
        fromJson: (json) => OnboardingRegisterPasswordResponse.fromJson(json));
  }
}
