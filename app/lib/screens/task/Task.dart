import 'package:awesome_notifications/src/models/received_models/received_action.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../../constants/Repetition.dart';



class Task {
  final String title;
  final String priority;
  final DateTime date;
  final String time;
  bool status;
  final Repetition repetition;

  Task({
    required this.title,
    required this.priority,
    required this.date,
    required this.time,
    this.status = false,
    this.repetition = Repetition.daily,
  });

  @override
  String toString() {
    return 'Task{title: $title, priority: $priority, date: $date, time: $time, status: $status, repetition: $repetition}';
  }
}





class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Task> tasks = [];
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priorityController = TextEditingController();
  DateTime _dateTime = DateTime.now();
  final _timeController = TextEditingController();
  final _repetitionController = TextEditingController();

  /// method to show a date picker and set the selected date to the _dateTime variable
  /// @param context
  /// @return Future<void>
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _dateTime) {
      setState(() {
        _dateTime = picked;
      });
    }
  }
  /// method to show a time picker and set the selected time to the _dateTime variable
  /// @param context
  /// @return Future<void>
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_dateTime),
    );
    if (picked != null) {
      setState(() {
        _dateTime = DateTime(
          _dateTime.year,
          _dateTime.month,
          _dateTime.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }


  // save task into firebase database and navigate to home screen
  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final task = Task(
        title: _titleController.text,
        priority: _priorityController.text,
        date: _dateTime,
        time: _timeController.text,
        repetition: Repetition.values.firstWhere(
          (element) => element.toString() == _repetitionController.text,
        ),
      );
      tasks.add(task);
      Navigator.pop(context, tasks);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add new task'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  // a Select input with values High, Normal and Low
                  DropdownButtonFormField<String>(
                    onChanged: (value) {
                      _priorityController.text = value!;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Priority',
                      border: OutlineInputBorder(),
                    ),
                    items: const <String>['High', 'Normal', 'Low']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a priority';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  InkWell(
                    onTap: () => _selectDate(context),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today),
                        const SizedBox(width: 8.0),
                        const Text(
                          'Date',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          '${_dateTime.year}-${_dateTime.month}-${_dateTime.day}',
                          style: const TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  InkWell(
                    onTap: () => _selectTime(context),
                    child: Row(
                      children: [
                        const Icon(Icons.access_time),
                        const SizedBox(width: 8.0),
                        const Text(
                          'Time',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          '${_dateTime.hour}:${_dateTime.minute}',
                          style: const TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // a Select input with values Daily, Weekly and Monthly
                  DropdownButtonFormField<String>(
                    onChanged: (value) {
                      _repetitionController.text = value!;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Schedule repetition',
                      border: OutlineInputBorder(),
                    ),
                    items: const <String>['Daily', 'Weekly', 'Monthly']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a schedule repetition';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final task = Task(
                          title: _titleController.text,
                          priority: _priorityController.text,
                          date: _dateTime,
                          time: _timeController.text,
                        );
                        print(task.toString());
                        // Do something with the task, like saving it to a database
                      }
                    },
                    child: const Text('Add Task'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
