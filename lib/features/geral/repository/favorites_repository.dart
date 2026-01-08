import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/geral/model/favorites_response.dart';

class FavoritesRepository {
  Future<List<FavoriteContactModel>> fetchFavorites(String document) async {
    return ApiConnection().get(
      endpoint: '${AppEndpoints.favorites}$document',
      fromJson: (json) {
        final list = json as List;

        return list.map((item) => FavoriteContactModel.fromJson(item)).toList();
      },
    );
  }
}
