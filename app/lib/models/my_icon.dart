import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mytask1/models/task.dart';
import 'package:mytask1/services/notification.dart';

import '../screens/task/Task.dart';



class MyIcon extends StatefulWidget {
  Task? task;
  MyIcon({super.key,required this.task });




  @override
  _MyIconState createState() => _MyIconState();

  }




class _MyIconState extends State<MyIcon> {
  bool isPressed = false;
  final notification = NotificationService();

  void toggleButton() {
    setState(() {
      isPressed = !isPressed;
      if (isPressed) {
        createNotification();
      } else {
        cancelNotification();
      }
    });
  }

  void createNotification() {
    // Use the awesome_notification plugin to create your notification here
    notification.displayNotification(widget.task!);
  }

  void cancelNotification() {
    // Use the awesome_notification plugin to cancel your notification here
    print('********* ${widget.task!.title} **********');
    notification.cancelNotification(widget.task!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        toggleButton();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        // animation wiggle the icon when pressed using a transform and rotate
        transform: isPressed
            ? Matrix4.translationValues(0, 0, 5) * Matrix4.rotationZ(0)
            : Matrix4.translationValues(0, 0, 5) * Matrix4.rotationZ(0),

        child: Icon(
          Icons.notifications,
          color: isPressed ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }
}