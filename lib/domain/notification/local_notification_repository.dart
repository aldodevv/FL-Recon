import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:recon/domain/notification/i_local_notification_repository.dart';

class LocalNotificationRepository extends ILocalNotificationRepository {
  final FlutterLocalNotificationsPlugin _localNotification =
      FlutterLocalNotificationsPlugin();
  final String _androidIcon = '@drawable/launch_background';

  @override
  Future<bool?> initialize(
    void Function(NotificationResponse p1) onDidReceiveNotificationResponse,
  ) async {
    return await _localNotification.initialize(
      InitializationSettings(
        android: AndroidInitializationSettings(_androidIcon),
        iOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  @override
  Future<NotificationAppLaunchDetails?>
  getNotificationAppLaunchDetails() async {
    return await _localNotification.getNotificationAppLaunchDetails();
  }

  @override
  Future<void> show(
    int id,
    String? title,
    String? body, {
    NotificationDetails? notificationDetails,
    String? payload,
  }) async {
    await _localNotification.show(
      id, 
      title, 
      body, 
      notificationDetails ?? NotificationDetails(
        android: AndroidNotificationDetails(
          'local',
          'local',
          icon: _androidIcon
        )
      ),
      payload: payload
    );
  }
}
