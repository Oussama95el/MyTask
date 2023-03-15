import 'dart:math';

import 'package:flutter/material.dart';

import '../../models/task.dart';

class UpdateForm extends StatefulWidget {
  final Task task;
  const UpdateForm({Key? key, required this.task}) : super(key: key);

  @override
  State<UpdateForm> createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {
  final List<String> priority =  ['High', 'Normal', 'Low'];
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priorityController = TextEditingController();
  DateTime _dateTime = DateTime.now();
  final _timeController = TextEditingController();
  final _repetitionController = TextEditingController();


  // methode that takes a String of time example 10:00 and returns a TimeOfDay object
  TimeOfDay _convertStringToTimeOfDay(String strTime) {
    final splittedTime = strTime.split(':');
    final hour = int.parse(splittedTime[0]);
    final minute = int.parse(splittedTime[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  /// method to show a time picker and set the selected time to the _dateTime variable
  /// @param context
  /// @return Future<void>
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _convertStringToTimeOfDay(widget.task.time),
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




  @override
  Widget build(BuildContext context) {
    return Form(
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
              // value: widget.task.priority,
              onChanged: (value) {
                _priorityController.text = value!;
              },
              decoration: const InputDecoration(
                labelText: 'Priority',
                border: OutlineInputBorder(),
              ),
              items: priority.map<DropdownMenuItem<String>>((String value) {
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
                    id: Random().nextInt(3332847),
                    title: _titleController.text,
                    priority: _priorityController.text,
                    date: _dateTime.toString(),
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
    );
  }
}


