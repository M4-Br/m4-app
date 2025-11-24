import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_basic_register_response.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_register_phone_request.dart';

class OnboardingRegisterPhoneRepository {
  Future<OnboardingBasicRegisterResponse> registerPhone(
      OnboardingRegisterPhone registerPhone) async {
    return await ApiConnection().post(
        endpoint: AppEndpoints.onboardingPhone,
        body: registerPhone.toJson(),
        fromJson: (json) => OnboardingBasicRegisterResponse.fromJson(json));
  }
}
