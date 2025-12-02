import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/pix/limits/model/pix_limits_response.dart';

class PixLimitsRepository {
  Future<PixLimitsResponse> fetchLimits() async {
    return ApiConnection().get(
        endpoint: AppEndpoints.pixLimits,
        fromJson: (json) => PixLimitsResponse.fromJson(json));
  }
}
