// ignore_for_file: prefer_const_constructors

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_flutternotification');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(
      int id, String title, String body, int seconds) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(Duration(microseconds: seconds)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
            'main_channel', 'Main Channel', //"Main channel notifications",
            importance: Importance.max,
            priority: Priority.max,
            icon: '@drawable/ic_flutternotification'),
        iOS: IOSNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  static Future _notifiyme() async {
    return NotificationDetails(
        android: AndroidNotificationDetails(
            'channel id', 'channel name', // 'channel description',
            importance: Importance.max,
            styleInformation: BigPictureStyleInformation(
                DrawableResourceAndroidBitmap("ic_flutternotification"),
                largeIcon:
                    DrawableResourceAndroidBitmap("ic_flutternotification"),
                contentTitle: "Demo image",
                summaryText: "this is a test",
                htmlFormatContent: true,
                htmlFormatContentTitle: true)));
  }

  Future showNotification1(
      {int id = 0, String? title, String? body, String? payload}) async {
    flutterLocalNotificationsPlugin.show(id, title, body, await _notifiyme(),
        payload: payload);
  }
}
