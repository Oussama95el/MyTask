import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mytask1/services/database.dart';
import '../../constants/Repetition.dart';
import '../../models/task.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final database = DatabaseService();

  List<Task> tasks = [];
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priorityController = TextEditingController();
  DateTime _date = DateTime.now();
  String _time = '${DateTime.now().hour}:${DateTime.now().minute}';
  final _repetitionController = TextEditingController();

  /// method to show a date picker and set the selected date to the _dateTime variable
  /// @param context
  /// @return Future<void>
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

  /// method to show a time picker and set the selected time to the _dateTime variable
  /// @param context
  /// @return Future<void>
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _time = '${picked.hour}:${picked.minute}';
      });
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
                          '${_date.year}-${_date.month}-${_date.day}',
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
                          _time,
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
                          id: Random().nextInt(3332847),
                          title: _titleController.text,
                          priority: _priorityController.text,
                          date: _date.toString(),
                          time: _time.toString(),
                          status: false,
                          repetition: _repetitionController.text,
                        );
                        // Do something with the task, like saving it to a database
                        database.saveTaskToFirestore(task);
                        Navigator.pop(context);
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
