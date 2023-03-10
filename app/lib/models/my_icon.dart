import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mytask1/services/notification.dart';

import '../screens/task/Task.dart';



class MyIcon extends StatefulWidget {
  bool _isPressed = false;
  bool get isPressed => _isPressed;
  set isPressed(bool value) { _isPressed = value; }
  Task? task;
  MyIcon({super.key,this.task });




  @override
  _MyIconState createState() => _MyIconState();




  // setTimerToNotification(String title, String priority, DateTime date, String time ) {
  //   final notificationTime = DateTime(
  //     date.year,
  //     date.month,
  //     date.day,
  //     int.parse(time.split(":")[0]),
  //     int.parse(time.split(":")[1]),
  //   );
  //   const oneSec = Duration(minutes: 1);
  //   Timer.periodic(
  //     oneSec,
  //         (timer) {
  //       final now = DateTime.now();
  //       if (now == notificationTime) {
  //         // Noti.showNotification(
  //         //     flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
  //         //     title: title,
  //         //     body: priority
  //         // );
  //         timer.cancel();
  //       }
  //     },
  //   );
  // }
  }




class _MyIconState extends State<MyIcon> {


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        setState(() {
          widget._isPressed = true;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        // animation wiggle the icon when pressed using a transform and rotate
        transform: widget._isPressed
            ? Matrix4.translationValues(0, 0, 5) * Matrix4.rotationZ(0)
            : Matrix4.translationValues(0, 0, 5) * Matrix4.rotationZ(0),

        child: Icon(
          Icons.notifications,
          color: widget._isPressed ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }
}