// file: notifications_page.dart

import 'package:app_flutter_miban4/core/helpers/utils/app_text.dart';
import 'package:app_flutter_miban4/features/notifications/controller/notifications_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsPage extends GetView<NotificationsController> {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AppText.titleMedium(context, 'notifications'.tr)),
      body: Obx(() {
        if (controller.isLoading.value && controller.notifications.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.notifications.isEmpty) {
          return const Center(child: Text('Nenhuma notificação encontrada.'));
        }

        return ListView.builder(
          controller: controller.scrollController,
          itemCount: controller.notifications.length + 1,
          itemBuilder: (context, index) {
            if (index == controller.notifications.length) {
              return Obx(() => controller.isLoadingMore.value
                  ? const Center(
                      child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ))
                  : const SizedBox.shrink());
            }

            final notification = controller.notifications[index];

            return ListTile(
              title: Text(notification.title),
              subtitle: Text(notification.description),
              trailing: notification.read
                  ? null
                  : const Icon(Icons.circle, color: Colors.blue, size: 12),
            );
          },
        );
      }),
    );
  }
}
