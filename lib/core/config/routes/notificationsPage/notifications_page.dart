import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/ui/screens/home/notifications/notifications_page.dart';
import 'package:get/get.dart';

class NotificationsPage {
  static final List<GetPage> notifications = [
    //Notifications Page
    GetPage(name: AppRoutes.notifications, page: () => const Notifications())
  ];
}
