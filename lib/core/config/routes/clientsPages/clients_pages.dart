import 'package:app_flutter_miban4/core/config/auth/service/auth_guard.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/clients/bindings/clients_binding.dart';
import 'package:app_flutter_miban4/features/clients/presentation/clients_page.dart';
import 'package:get/get.dart';

class ClientsPages {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.clients,
        page: () => ClientsPage(),
        binding: ClientsBinding(),
        middlewares: [AuthGuard()]),
  ];
}
