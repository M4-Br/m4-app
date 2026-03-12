import 'package:app_flutter_miban4/core/config/auth/service/auth_guard.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/newsletter/binding/newsletter_binding.dart';
import 'package:app_flutter_miban4/features/newsletter/presentation/newsletter_page.dart';
import 'package:get/get.dart';

class NewsletterPages {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.newsletter,
        page: () => NewsletterPage(),
        binding: NewsletterBinding(),
        middlewares: [AuthGuard()]),
  ];
}
