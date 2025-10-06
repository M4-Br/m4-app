import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/app_connection.dart';
import 'package:app_flutter_miban4/features/home/model/home_icons_response.dart';

class FetchIconsRepository {
  Future<List<HomeIconsResponse>> fetchIcons() async {
    return await ApiConnection().get<List<HomeIconsResponse>>(
      endpoint: AppEndpoints.fetchIcons,
      fromJson: (json) {
        if (json is Map<String, dynamic> && json['home_items'] is List) {
          return (json['home_items'] as List)
              .map((e) => HomeIconsResponse.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception('Expected a list in home_items but got: $json');
        }
      },
    );
  }
}
