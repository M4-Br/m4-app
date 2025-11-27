import 'package:app_flutter_miban4/core/helpers/connection/api_exception.dart';
import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_toaster.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_flutter_miban4/core/config/log/logger.dart';
import 'package:app_flutter_miban4/features/notifications/model/notifications_response.dart';
import 'package:app_flutter_miban4/features/notifications/repository/notifications_repository.dart';

class NotificationsController extends GetxController {
  var isLoading = false.obs;
  final notifications = <Notifications>[].obs;
  var hasUnreadNotifications = false.obs;

  var currentPage = 1.obs;
  var lastPage = 1.obs;
  var isLoadingMore = false.obs;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    fetchNotificationsList();
    scrollController.addListener(_scrollListener);
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.onClose();
  }

  Future<void> fetchNotificationsList({bool isFirstLoad = true}) async {
    if (isFirstLoad) {
      isLoading(true);
    } else {
      if (isLoadingMore.value || currentPage.value >= lastPage.value) return;
      isLoadingMore(true);
    }

    try {
      final pageToFetch = isFirstLoad ? 1 : currentPage.value + 1;
      final response =
          await NotificationsRepository().fetchNotifications(page: pageToFetch);

      if (response.notifications != null) {
        if (isFirstLoad) {
          notifications.assignAll(response.notifications!);
        } else {
          notifications.addAll(response.notifications!);
        }
        currentPage.value = response.currentPage;
        lastPage.value = response.lastPage;
      }
    } on UnauthorizedException catch (e) {
      ShowToaster.toasterInfo(message: e.message);
      rethrow;
    } on ApiException catch (e) {
      ShowToaster.toasterInfo(message: e.message);
      rethrow;
    } catch (e, s) {
      AppLogger.I().error('Fetch Notifications', e, s);
      rethrow;
    } finally {
      if (isFirstLoad) {
        isLoading(false);
      } else {
        isLoadingMore(false);
      }
    }
  }

  void _scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent * 0.8) {
      fetchNotificationsList(isFirstLoad: false);
    }
  }

  Future<void> checkUnreadStatus() async {
    try {
      final response = await NotificationsRepository().fetchNotifications();

      if (response.notifications == null || response.notifications!.isEmpty) {
        hasUnreadNotifications.value = false;
        return;
      }

      final bool hasUnread =
          response.notifications!.any((notification) => !notification.read);

      hasUnreadNotifications.value = hasUnread;
    } catch (e, s) {
      AppLogger.I().error('Check Unread Status', e, s);
      rethrow;
    }
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      await NotificationsRepository()
          .makeNotificationRead(notificationId: notificationId);

      final index =
          notifications.indexWhere((n) => n.id.toString() == notificationId);
      if (index != -1) {
        final updatedNotification = notifications[index];

        notifications[index] = Notifications(
          id: updatedNotification.id,
          userId: updatedNotification.userId,
          notificationTypeId: updatedNotification.notificationTypeId,
          description: updatedNotification.description,
          read: true,
          notificationData: updatedNotification.notificationData,
          notificationName: updatedNotification.notificationName,
          notificationAction: updatedNotification.notificationAction,
          title: updatedNotification.title,
        );
        notifications.refresh();
      }

      checkUnreadStatus();
    } catch (e, s) {
      AppLogger.I().error('Mark As Read', e, s);
      rethrow;
    }
  }
}
