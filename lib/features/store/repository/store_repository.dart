import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/store/model/store_response.dart';

class StoreRepository {
  Future<List<StoreResponse>> fetchStore() async {
    return await ApiConnection().get(
      endpoint: AppEndpoints.store,
      fromJson: (json) {
        final list = json['merchants'] as List? ?? [];

        return list.map((item) => StoreResponse.fromJson(item)).toList();
      },
    );
  }
}
