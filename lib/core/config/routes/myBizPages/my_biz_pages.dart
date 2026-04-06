import 'package:app_flutter_miban4/core/config/auth/service/auth_guard.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/myBiz/bindings/my_biz_binding.dart';
import 'package:app_flutter_miban4/features/myBiz/presentation/my_biz_home_page.dart';
import 'package:get/get.dart';

class MyBizPages {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.myBiz,
        page: () => MyBizPage(),
        binding: MyBizBinding(),
        middlewares: [AuthGuard()]),
  ];
}
