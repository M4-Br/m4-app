import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/onboarding/model/onboarding_document_register_response.dart';

class OnboardingDocumentRepository {
  Future<OnboardingDocumentRegisterResponse> basicRegister(
      String document) async {
    return await ApiConnection().post(
        endpoint: AppEndpoints.onboardingDocument,
        body: {'document': document},
        fromJson: (json) => OnboardingDocumentRegisterResponse.fromJson(json));
  }
}
