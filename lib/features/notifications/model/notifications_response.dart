class NotificationsResponse {
  const NotificationsResponse({
    required this.currentPage,
    required this.lastPage,
    required this.total,
    required this.notifications,
  });

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) {
    return NotificationsResponse(
        currentPage: json['current_page'] as int,
        lastPage: json['last_page'] as int,
        total: json['total'] as int,
        notifications: (json['data'] as List<dynamic>)
            .map((e) => Notifications.fromJson(e))
            .toList());
  }

  final int currentPage;
  final int lastPage;
  final int total;
  final List<Notifications>? notifications;
}

class Notifications {
  const Notifications({
    required this.id,
    required this.userId,
    required this.title,
    required this.notificationTypeId,
    required this.description,
    required this.read,
    required this.notificationData,
    required this.notificationName,
    required this.notificationAction,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
        id: json['id'] as int,
        userId: json['user_id'] as int,
        title: json['title'] as String,
        notificationTypeId: json['notification_type_id'] as int,
        description: json['description'] as String,
        read: json['read'] as bool,
        notificationData: json['notification_data'] as String,
        notificationName: json['notification_name'] as String,
        notificationAction: json['notification_action'] as String);
  }

  final int id;
  final int userId;
  final String title;
  final int notificationTypeId;
  final String description;
  final bool read;
  final String notificationData;
  final String notificationName;
  final String notificationAction;
}
