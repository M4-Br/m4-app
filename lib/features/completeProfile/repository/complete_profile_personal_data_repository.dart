import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/completeProfile/model/complete_profile_personal_data_request.dart';
import 'package:app_flutter_miban4/features/completeProfile/model/complete_profile_response.dart';

class CompleteProfilePersonalDataRepository {
  Future<CompleteProfileResponse> sendPersonalData(
      CompleteProfilePersonalDataRequest request) async {
    return ApiConnection().post(
        endpoint: AppEndpoints.completePersonalData,
        body: request.toJson(),
        fromJson: (json) => CompleteProfileResponse.fromJson(json));
  }
}
