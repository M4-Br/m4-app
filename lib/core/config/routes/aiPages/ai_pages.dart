import 'package:app_flutter_miban4/core/config/auth/service/auth_guard.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/ai/bindings/ai_manager_binding.dart';
import 'package:app_flutter_miban4/features/ai/presentation/ai_manager_page.dart';
import 'package:get/get.dart';

class AiPages {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.aiPage,
        page: () => AiManagerPage(),
        binding: AiManagerBinding(),
        middlewares: [AuthGuard()]),
  ];
}
