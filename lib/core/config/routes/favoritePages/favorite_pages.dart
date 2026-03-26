import 'package:app_flutter_miban4/core/config/auth/service/auth_guard.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/favorites/bindings/favorites_bindings.dart';
import 'package:app_flutter_miban4/features/favorites/presentation/favorites_page.dart';
import 'package:get/get.dart';

class FavoritePages {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.favButtons,
        page: () => FavoritesPage(),
        binding: FavoritesBindings(),
        middlewares: [AuthGuard()]),
  ];
}
