import 'package:app_flutter_miban4/core/config/auth/service/auth_guard.dart';
import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/contact/bindings/contacts_binding.dart';
import 'package:app_flutter_miban4/features/contact/presentation/contact_controller.dart';
import 'package:get/get.dart';

class ContactPages {
  static final List<GetPage> pages = [
    GetPage(
        name: AppRoutes.contacts,
        page: () => ContactPage(),
        binding: ContactsBinding(),
        middlewares: [AuthGuard()]),
  ];
}
