import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/web/bindings/web_view_bindings.dart';
import 'package:app_flutter_miban4/features/web/presentation/web_view_page.dart';
import 'package:get/get.dart';

class WebveiewPages {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.webView,
        page: () => const WebviewPage(),
        binding: WebViewBindings()),
  ];
}
