import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/completeProfile/model/complete_profile_address_request.dart';
import 'package:app_flutter_miban4/features/completeProfile/model/complete_profile_response.dart';

class CompleteProfileAddressRepository {
  Future<CompleteProfileResponse> sendAddress(
      CompleteProfileAddressRequest request) async {
    return ApiConnection().post(
        endpoint: AppEndpoints.completeAddress,
        body: request.toJson(),
        fromJson: (json) => CompleteProfileResponse.fromJson(json));
  }
}
