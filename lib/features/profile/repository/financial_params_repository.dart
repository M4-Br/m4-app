import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/profile/model/capacity_response.dart';
import 'package:app_flutter_miban4/features/profile/model/params_reponse.dart';

class FinancialParamsRepository {
  Future<ParamsReponse> fetchFinancial() async {
    return await ApiConnection().get(
        endpoint: AppEndpoints.userParams,
        fromJson: (json) => ParamsReponse.fromJson(json));
  }

  Future<CapacityResponse> fetchCapacity({required String userId}) async {
    return await ApiConnection().get(
        endpoint: '${AppEndpoints.userCapacity}$userId',
        fromJson: (json) => CapacityResponse.fromJson(json));
  }
}
