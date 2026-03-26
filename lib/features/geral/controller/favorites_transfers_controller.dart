import 'package:app_flutter_miban4/core/helpers/controller/base_controller.dart';
import 'package:app_flutter_miban4/features/geral/model/favorites_response.dart';
import 'package:app_flutter_miban4/features/geral/repository/favorites_repository.dart';
import 'package:get/get.dart';

class FavoritesTransfersController extends BaseController {
  final FavoritesRepository _repository = FavoritesRepository();
  final favoritesList = <FavoriteContactModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getFavorites();
  }

  Future<void> getFavorites() async {
    final document = userRx.user.value?.payload.document;

    if (document == null) return;

    await executeSafe(() async {
      final result = await _repository.fetchFavorites(document);

      favoritesList.assignAll(result);
    });
  }
}
