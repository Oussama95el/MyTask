import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import '../models/task.dart';

class NotificationService {


  List<int> _timeToArray(String time) {
    List<int> timeArray = [];
    time.split(':').forEach((element) {
      timeArray.add(int.parse(element));
    });
    return timeArray;
  }


  List<int> _dateToArray(String date) {

    print(date);
    // split the date by whitespace
    date = date.split(' ')[0];
    List<int> dateArray = [];
    dateArray.add(int.parse(date.substring(0, 4)));
    dateArray.add(int.parse(date.substring(5, 7)));
    dateArray.add(int.parse(date.substring(8, 10)));
    return dateArray;
  }



  displayNotification(Task task)  {
    List<int> timeArray = _timeToArray(task.time);
    List<int> dateArray = _dateToArray(task.date);
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: task.id,
            channelKey: 'basic_channel',
            title: task.title,
            body: task.priority),
        schedule: NotificationCalendar(
            year: dateArray[0],
            month: dateArray[1],
            day: dateArray[2],
            hour: timeArray[0],
            minute: timeArray[1],
            repeats: true,
        )

    );
  }

  cancelNotification(Task task) {
    print('canceling notification ${task.id}');
    AwesomeNotifications().cancel(task.id);
  }
}