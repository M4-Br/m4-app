import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/pix/scheduled/model/pix_schedule_response.dart';

class PixScheduleRepository {
  Future<PixScheduledResponse> fetchScheduledPix() async {
    return ApiConnection().get(
        endpoint: AppEndpoints.pixScheduled,
        fromJson: (json) => PixScheduledResponse.fromJson(json));
  }
}
