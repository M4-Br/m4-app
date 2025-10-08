import 'package:app_flutter_miban4/core/config/consts/paths/app_endpoints.dart';
import 'package:app_flutter_miban4/core/helpers/connection/api_connection.dart';
import 'package:app_flutter_miban4/features/notifications/model/notifications_response.dart';

class NotificationsRepository {
  Future<NotificationsResponse> fetchNotifications({int page = 1}) async {
    return await ApiConnection().get(
        endpoint: '${AppEndpoints.notifications}?page=$page',
        fromJson: (json) => NotificationsResponse.fromJson(json));
  }

  Future<void> makeNotificationRead({required String notificationId}) async {
    return await ApiConnection().post(
        endpoint: '${AppEndpoints.notifications}/$notificationId',
        fromJson: (json) {});
  }
}
