import 'package:app_flutter_miban4/data/api/notifications/getNotifications.dart';
import 'package:app_flutter_miban4/data/api/notifications/notifications_read.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  var isLoading = false.obs;
  Rx<Map<String, dynamic>> notificationsData = Rx<Map<String, dynamic>>({});
  var hasUnreadNotifications = false.obs;

  Future<void> fetchNotifications() async {
    isLoading(true);
    try {
      final Map<String, dynamic> data = await getNotifications();
      notificationsData.value = data;
    } catch (e) {
      isLoading(false);
      throw Exception(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> notificationsIcon() async {
    try {
      final Map<String, dynamic> data = await getNotifications();

      final List<dynamic> notifications = data['data'];

      final bool hasUnread =
          notifications.any((notification) => notification['read'] == false);
      hasUnreadNotifications(hasUnread);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> makeRead(String notId) async {
    try {
      await readNotifications(notId);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
