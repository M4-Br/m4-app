import 'package:app_flutter_miban4/core/config/auth/service/auth_guard.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/documents/bindings/documents_binding.dart';
import 'package:app_flutter_miban4/features/documents/presentation/documents_page.dart';
import 'package:get/get.dart';

class DocumentsPages {
  static final pages = [
    GetPage(
      name: AppRoutes.documents,
      page: () => const DocumentsPage(),
      binding: DocumentsBinding(),
      middlewares: [AuthGuard()],
    ),
  ];
}
