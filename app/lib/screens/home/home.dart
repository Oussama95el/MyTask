import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mytask1/screens/home/pagination_widget.dart';
import 'package:mytask1/screens/home/task_list.dart';
import '../../models/my_icon.dart';
import '../../models/task.dart';
import '../../services/auth.dart';
import '../task/Task.dart';
import 'package:mytask1/services/database.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final String? title;
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static const String name = 'Awesome Notifications - Example App';
  static const Color mainColor = Colors.deepPurple;

  const HomePage({super.key, this.title});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  get addTask => null;

  // state of the icon
  final MyIcon myIcon = MyIcon(task: null);

  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _auth = AuthService();


    return StreamProvider<List<Task>>(
      create: (context) => DatabaseService().tasks,
      initialData: const [],
      catchError: (context, error) {
        // Handle the error here
        print('Error: $error');
        return [];
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Task Manage'),
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.add),
                          title: const Text('Add Task'),
                          onTap: () {
                            // Close the modal and perform the Add Task action
                            Navigator.pop(context);
                            // Add Task code goes here
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TaskScreen(),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.logout),
                          title: const Text('Logout'),
                          onTap: () async {
                            // Close the modal and perform the Logout action
                            Navigator.pop(context);
                            // Logout code goes here
                            await _auth.signOut();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child:  const TaskList(),
        ),

      ),
    );
  }
}

//
// Container(
// padding: const EdgeInsets.all(20),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// const Text(
// 'Task Manage',
// style: TextStyle(
// fontSize: 20,
// fontWeight: FontWeight.bold,
// ),
// ),
// ElevatedButton(
// onPressed: () {
// // //  display the task screen
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => const TaskScreen(),
// ),
// );
// },
// child: const Text('Add Task'),
// ),
// ],
// ),
// ),
// // body with list of tasks
// Expanded(
// child: Container(
// padding: const EdgeInsets.symmetric(horizontal: 20),
// decoration: const BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.only(
// topLeft: Radius.circular(40),
// topRight: Radius.circular(40),
// ),
// ),
// child: const TaskList(),
// ),
// ),
