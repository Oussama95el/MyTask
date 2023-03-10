import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:mytask1/screens/task/Task.dart';

class NotificationService {


  List<int> _timeToArray(String time) {
    List<int> timeArray = [];
    timeArray.add(int.parse(time.substring(0, 2)));
    timeArray.add(int.parse(time.substring(3, 5)));
    return timeArray;
  }

  List<int> _dateToArray(String date) {
    List<int> dateArray = [];
    dateArray.add(int.parse(date.substring(0, 2)));
    dateArray.add(int.parse(date.substring(3, 5)));
    dateArray.add(int.parse(date.substring(6, 10)));
    return dateArray;
  }



  displayNotification(Task task)  {
    final id = Random().nextInt(3332847);

    List<int> timeArray = _timeToArray(task.time);

    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: id,
            channelKey: 'basic_channel',
            title: task.title,
            body: task.priority),
        schedule: NotificationCalendar(
            allowWhileIdle: true,
            hour: timeArray[0],
            minute: timeArray[1],
            second: 0,
            repeats: true)
    );
  }
}