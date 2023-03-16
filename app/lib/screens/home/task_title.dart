import 'package:flutter/material.dart';
import 'package:mytask1/screens/home/update_form.dart';
import 'package:mytask1/services/database.dart';
import '../../models/my_icon.dart';
import '../../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  const TaskTile({Key? key, required this.task}) : super(key: key);





  @override
  Widget build(BuildContext context) {


    String formatDate(String date) {
      // Format the date to display day, month and year
      return '${date.substring(8, 10)}/${date.substring(5, 7)}/${date.substring(0, 4)}';
    }


    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(4.0, 6.0, 4.0, 0.0),
        child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyIcon(task: task),
          ),
          title: Text('${task.title} - ${task.priority}'),
          subtitle: Text('Due Date: ${formatDate(task.date)} - ${task.time}'),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.update),
                      title: const Text('Update Task'),
                      onTap: () {
                       // show modal bottom sheet
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => UpdateForm(task: task),
                        );
                        // Close the modal and perform the Update Task action
                        Navigator.pop(context);
                      }
                    ),
                     ListTile(
                      leading: Icon(Icons.delete),
                      title: Text('Delete Task'),
                       onTap: () {
                         // Delete Task code goes here
                         DatabaseService().deleteTask(task.id);
                         // Close the modal and perform the Delete Task action
                         Navigator.pop(context);

                       }
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
