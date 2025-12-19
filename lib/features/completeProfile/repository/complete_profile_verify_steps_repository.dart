import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/completeProfile/model/complete_profile_response.dart';

class CompleteProfileVerifyStepsRepository {
  Future<CompleteProfileResponse> fetchProfileSteps(String document) async {
    return ApiConnection().get(
        endpoint: '${AppEndpoints.getDocument}/$document',
        fromJson: (json) => CompleteProfileResponse.fromJson(json));
  }
}
