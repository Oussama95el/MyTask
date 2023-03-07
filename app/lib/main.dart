import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mytask1/screens/task/Task.dart';

import '/screens/home/home.dart';
import 'controller/NotificationController.dart';



void main()  {
  AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static const String name = 'MyTask Manager App';
  static const Color mainColor = Colors.deepPurple;


  @override
  _MyAppState createState() => _MyAppState();



}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    // remove the debug banner
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    @override
    void initState() {

      // Only after at least the action method is set, the notification events are delivered
      AwesomeNotifications().setListeners(
          onActionReceivedMethod:         NotificationController.onActionReceivedMethod,
          onNotificationCreatedMethod:    NotificationController.onNotificationCreatedMethod,
          onNotificationDisplayedMethod:  NotificationController.onNotificationDisplayedMethod,
          onDismissActionReceivedMethod:  NotificationController.onDismissActionReceivedMethod
      );



      super.initState();
    }

    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
      return MaterialApp(

        // The navigator key is necessary to allow to navigate through static methods
        navigatorKey: MyApp.navigatorKey,

        title: MyApp.name,
        color: MyApp.mainColor,

        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (context) =>
                  const HomePage( title: MyApp.name)
              );

            case '/addTask':
              return MaterialPageRoute(builder: (context) {
                final ReceivedAction receivedAction = settings
                    .arguments as ReceivedAction;
                return TaskScreen(receivedAction: receivedAction);
              });

            default:
              assert(false, 'Page ${settings.name} not found');
              return null;
          }
        },

        theme: ThemeData(
            primarySwatch: Colors.deepPurple
        ),
      );
    }

    return const MaterialApp(
      title: 'MyTask App',
      home:  HomePage(),
    );
  }
}

