import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/geral/model/cep_response.dart';

class CepRepository {
  Future<CepResponse> fetchCep(String cep) async {
    return ApiConnection().get(
        endpoint: AppEndpoints.cep,
        fromJson: (json) => CepResponse.fromJson(json),
        queryParameters: {'zip_code': cep});
  }
}
