import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_one_request.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_one_response.dart';

class OnboardingOneRepository {
  Future<OnboardingOneResponse> basicRegister(
      OnboardingOneRequest onboarding) async {
    return await ApiConnection().post(
        endpoint: AppEndpoints.onboardingOne,
        body: onboarding,
        fromJson: (json) => OnboardingOneResponse.fromJson(json));
  }
}
