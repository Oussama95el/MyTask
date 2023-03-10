import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:mytask1/screens/task/Task.dart';

class NotificationService {


  displayNotification(Task task)  {
    final id = Random().nextInt(3332847);

    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: id,
            channelKey: 'basic_channel',
            title: task.title,
            body: task.priority),

    );
  }
}