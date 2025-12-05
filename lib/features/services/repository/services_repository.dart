import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/services/model/services_response.dart';

class ServicesRepository {
  Future<ServicesResponse> fetchServices() async {
    return await ApiConnection().get(
        endpoint: AppEndpoints.services,
        fromJson: (json) => ServicesResponse.fromJson(json));
  }
}
