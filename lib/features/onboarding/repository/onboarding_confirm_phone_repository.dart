import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_basic_register_response.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_verify_phone_request.dart';

class OnboardingConfirmPhoneRepository {
  Future<OnboardingBasicRegisterResponse> confirmPhone(
      OnboardingVerifyPhoneRequest request) async {
    return await ApiConnection().post(
        endpoint: AppEndpoints.onboardingPhoneConfirm,
        body: request.toJson(),
        fromJson: (json) => OnboardingBasicRegisterResponse.fromJson(json));
  }
}
