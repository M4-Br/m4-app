import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_basic_register_response.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_verify_email_request.dart';

class OnboardingVerifyEmailTokenRepository {
  Future<OnboardingBasicRegisterResponse> validateToken(
      OnboardingVerifyEmailRequest request) async {
    return ApiConnection().post(
        endpoint: AppEndpoints.onboardingConfirmEmail,
        body: request.toJson(),
        fromJson: (json) => OnboardingBasicRegisterResponse.fromJson(json));
  }
}
