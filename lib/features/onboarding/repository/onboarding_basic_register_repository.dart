import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_basic_register_request.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_basic_register_response.dart';

class OnboardingBasicRegisterRepository {
  Future<OnboardingBasicRegisterResponse> basicRegister(
      OnboardingBasicRegisterRequest request) async {
    return await ApiConnection().post(
        endpoint: AppEndpoints.onboardingBasicData,
        body: request.toJson(),
        fromJson: (json) => OnboardingBasicRegisterResponse.fromJson(json));
  }
}
