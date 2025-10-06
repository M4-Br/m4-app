import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/ui/screens/home/services/services_page.dart';
import 'package:get/get.dart';

class ServicesPages {
  static final List<GetPage> pages = [
    //Services
    GetPage(name: AppRoutes.services, page: () => const ServicesPage()),
  ];
}
