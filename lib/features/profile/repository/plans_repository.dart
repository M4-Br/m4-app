import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/profile/model/plans_response.dart';

class PlansRepository {
  Future<List<PlanItem>> fetchPlans() async {
    return await ApiConnection().get(
      endpoint: AppEndpoints.plans,
      fromJson: (json) {
        List<PlanItem> allPlans = [];

        if (json is List) {
          for (var element in json) {
            if (element['success'] == true && element['itens'] != null) {
              final items = (element['itens'] as List)
                  .map((i) => PlanItem.fromJson(i))
                  .toList();
              allPlans.addAll(items);
            }
          }
        }
        return allPlans;
      },
    );
  }
}
