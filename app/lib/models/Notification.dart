import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class Noti {
  // initialize the notification
  static Future initialize( FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var android = const AndroidInitializationSettings('mipmap/ic_launcher');
    var iOS = const IOSInitializationSettings();
    var initSettings = InitializationSettings(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  // methode that call the notification based on the time
  static Future showNotification({
    required String title,
    required String body,
    required String payload,
    required FlutterLocalNotificationsPlugin fln
  }) async {
    int id = Random().nextInt(3332847);
    print('$id **********');
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
            'Task Notification',
            'Reminder',
            playSound: true,
            // sound:RawResourceAndroidNotificationSound('notification'),
            enableVibration: true,
            importance: Importance.max,
            priority: Priority.high
        );

    var not = NotificationDetails(android: androidPlatformChannelSpecifics,
        iOS: const IOSNotificationDetails());
    await fln.show(id, title, body, not,
        payload: payload);
  }
}
