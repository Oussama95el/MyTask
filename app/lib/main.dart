import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mytask1/firebase_options.dart';
import 'package:mytask1/models/user.dart';
import 'package:mytask1/screens/authenticate/register.dart';
import 'package:mytask1/screens/authenticate/sign_in.dart';
import 'package:mytask1/screens/task/Task.dart';
import 'package:mytask1/screens/wrapper.dart';
import 'package:mytask1/screens/error_page.dart';
import 'package:mytask1/services/auth.dart';
import 'package:provider/provider.dart';
import '/screens/home/home.dart';
import 'controller/notification_controller.dart';

bool shouldUseFirestoreEmulator = false;

Future<void> main() async {
  // This is required to initialize the plugin
  WidgetsFlutterBinding.ensureInitialized();
  // This is required to initialize the plugin for Android Notifications
  AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for task',
            defaultColor: Colors.blue,
            ledColor: Colors.white)
      ]);
  // Firebase.initializeApp() is required to use Firebase services
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Check if firestore emulator is running
  if (shouldUseFirestoreEmulator) {
    FirebaseFirestore.instance.useFirestoreEmulator("localhost", 8080);
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();
  static const String name = 'MyTask Manager App';
  static const Color mainColor = Colors.blue;

  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
        NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
        NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
        NotificationController.onDismissActionReceivedMethod);

    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        // The navigator key is necessary to allow to navigate through static methods
        navigatorKey: MyApp.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: MyApp.name,
        color: MyApp.mainColor,
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (context) => Wrapper());

            case '/home':
              return MaterialPageRoute(
                  builder: (context) => const HomePage(title: MyApp.name));

            case '/addTask':
              return MaterialPageRoute(builder: (context) {
                return const TaskScreen();
              });
            case '/signIn':
              return MaterialPageRoute(builder: (context) {
                return const SignIn();
              });

            case '/register':
              return MaterialPageRoute( builder: (context) => Register());
            default:
              MaterialPageRoute(
                  builder: (context) =>
                      ErrorPage(
                        errorCode: 404,
                        errorMessage: 'The page ${settings
                            .name} does not exist',
                      ));
              assert(false, 'Page ${settings.name} not found');
              return null;
          }
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
              builder: (context) =>
                  ErrorPage(
                    errorCode: 404,
                    errorMessage: 'The page ${settings.name} does not exist',
                  ));
        },
        theme: ThemeData(primarySwatch: Colors.blue),
      ),
    );
  }
}
