import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/profile/model/plans_response.dart';

class PlansRepository {
  Future<UserPlansResponse> fetchPlans({required String accountId}) async {
    return await ApiConnection().get(
        endpoint: '${AppEndpoints.userPlans}$accountId',
        fromJson: (json) => UserPlansResponse.fromJson(json));
  }
}
