import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mytask1/models/Notification.dart';
import '../screens/details/Task.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class MyIcon extends StatefulWidget {
  @override
  _MyIconState createState() => _MyIconState();

  setTimerToNotification(String title, String priority, DateTime date, String time ) {
    final notificationTime = DateTime(
      date.year,
      date.month,
      date.day,
      int.parse(time.split(":")[0]),
      int.parse(time.split(":")[1]),
    );

   print(notificationTime);
    const oneSec = Duration(seconds: 1);
     Timer.periodic(
      oneSec,
          (timer) {
        final now = DateTime.now();
        if (now == notificationTime) {
          Noti.showNotification(
              flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
              title: title,
              body: priority,
              payload: time);
          timer.cancel();
        }
      },
    );

  }
}

class _MyIconState extends State<MyIcon> {
  bool _isPressed = false;


  // method that return state of _isPressed
  bool getIsPressed() {
    return _isPressed;
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = !_isPressed;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        // animation wiggle the icon when pressed using a transform and rotate
        transform: _isPressed
            ? Matrix4.translationValues(0, 0, 5) * Matrix4.rotationZ(0)
            : Matrix4.translationValues(0, 0, 5) * Matrix4.rotationZ(0),

        child: Icon(
          Icons.notifications,
          color: _isPressed ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }
}