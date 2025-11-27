import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/balance/model/balance_response.dart';

class BalanceRepository {
  Future<BalanceResponse> fetchBalance() async {
    return await ApiConnection().get(
        endpoint: AppEndpoints.balance,
        fromJson: (json) => BalanceResponse.fromJson(json));
  }
}
