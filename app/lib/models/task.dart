

import 'dart:math';

import '../constants/Repetition.dart';

class Task {
  final int id;
  final String title;
  final String priority;
  final String date;
  final String time;
  bool status;
  final String repetition;

  Task({
    required this.id,
    required this.title,
    required this.priority,
    required this.date,
    required this.time,
    this.status = false,
    this.repetition = "daily"
  });

  @override
  String toString() {
    return 'Task{title: $title, priority: $priority, date: $date, time: $time, status: $status, repetition: $repetition}';
  }
}