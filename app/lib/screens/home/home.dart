import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../models/MyIcon.dart';
import '../../models/Notification.dart';
import '../details/Task.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  get addTask => null;
  // state of the icon
  late MyIcon _myIconState;

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  void initState() {
    super.initState();
    _myIconState = MyIcon();
  }

  @override
  Widget build(BuildContext context) {
    // formated date for the task


    var tasks = [
      Task(
          title: "Buy groceries",
          priority: "High",
          date: DateTime.now().add(const Duration(days: 1)),
          time: "10:00"),
      Task(
          title: "Attend meeting",
          priority: "Normal",
          date: DateTime.now(),
          time: "14:00"),
      Task(
          title: "Complete project",
          priority: "High",
          date: DateTime.now(),
          time: "12:00"),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Task Manage',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                  //  display the task screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskScreen(
                          addTask: addTask,
                        ),
                      ),
                    );
                  },
                  child: const Text('Add Task'),
                ),
              ],
            ),
          ),
          // body with list of tasks
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index].title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        'Priority: ${tasks[index].priority}',
                        style: TextStyle(
                          // change color based on priority
                          color: tasks[index].priority == 'High'
                              ? Colors.red
                              : tasks[index].priority == 'Normal'
                                  ? Colors.green
                                  : Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text('Date: ${tasks[index].date}'),
                      const SizedBox(height: 5),
                      Text('Time: ${tasks[index].time}'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: MyIcon(),
                    onPressed: () => _myIconState.setTimerToNotification(
                      tasks[index].title,
                      tasks[index].priority,
                      tasks[index].date,
                      tasks[index].time,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
