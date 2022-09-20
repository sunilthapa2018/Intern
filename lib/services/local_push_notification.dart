import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  LocalNotificationService() {
    initializeNotification();
  }

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> initializeNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@drawable/ic_stat_app_icon');

    DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: darwinInitializationSettings,
    );

    // await _localNotificationService.initialize(initializationSettings,
    //     onSelectedNotification: onSelectedNotification);
    await _localNotificationService.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  Future<NotificationDetails> _notificationDetails() async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('main_channel', 'Main Channel',
            importance: Importance.max,
            priority: Priority.max,
            icon: '@mipmap/ic_launcher');
    DarwinNotificationDetails iosNotificationDetails =
        const DarwinNotificationDetails(
      sound: 'default.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    return NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final notificationDetails = await _notificationDetails();
    await _localNotificationService.show(id, title, body, notificationDetails);
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    log("id = $id");
  }

  void onSelectedNotification(String? payload) {
    log("payload = $payload");
  }

  void onDidReceiveNotificationResponse(NotificationResponse details) {}
}
