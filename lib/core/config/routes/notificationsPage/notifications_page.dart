import 'package:app_flutter_miban4/core/config/routes/app_routes.dart';
import 'package:app_flutter_miban4/features/notifications/presentation/notifications_page.dart';
import 'package:get/get.dart';

class NotificationPage {
  static final List<GetPage> notifications = [
    //Notifications Page
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsPage(),
    )
  ];
}
