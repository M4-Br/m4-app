import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/store/bindings/store_bindings.dart';
import 'package:app_flutter_miban4/features/store/presentation/store_page.dart';
import 'package:get/get.dart';

class StorePages {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.store,
        page: () => const StorePage(),
        binding: StoreBindings()),
  ];
}
