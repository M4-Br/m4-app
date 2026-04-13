import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/mei/model/das_model.dart';

class MeiRepository {
  Future<DasResponseModel> gerarDas(DasRequestModel requestBody) async {
    return ApiConnection().post(
        endpoint: AppEndpoints.fetchDAS,
        body: requestBody.toJson(),
        fromJson: (json) => DasResponseModel.fromJson(json));
  }
}
