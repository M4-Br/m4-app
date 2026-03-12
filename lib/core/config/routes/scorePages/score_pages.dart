import 'package:app_flutter_miban4/core/config/auth/service/auth_guard.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/score/binding/score_binding.dart';
import 'package:app_flutter_miban4/features/score/presentation/score_page.dart';
import 'package:get/get.dart';

class ScorePages {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.score,
        page: () => ScorePage(),
        binding: ScoreBindings(),
        middlewares: [AuthGuard()]),
  ];
}
