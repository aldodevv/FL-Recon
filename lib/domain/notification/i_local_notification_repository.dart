import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class ILocalNotificationRepository {
  Future<bool?> initialize(
    void Function(NotificationResponse) onDidReceiveNotificationResponse,
  );

  Future<NotificationAppLaunchDetails?> getNotificationAppLaunchDetails();
  Future<void> show(
    int id,
    String? title,
    String? body, {
    NotificationDetails? notificationDetails,
    String? payload,
  });
}
