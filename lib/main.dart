import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:food_app_project/routes/routes.dart';
import 'package:food_app_project/screen/splash_page.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

Fluttertoast? flutterToast;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  // FirebaseMessaging.instance
  //     .getToken()
  //     .then((value) => {print("get token: $value")});
  //
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //       (RemoteMessage message) async {
  //     print("openMessageOpenedApp: $message");
  //   };
  // });
  //
  // FirebaseMessaging.instance.getInitialMessage().then((value) => {});
  //
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //
  // OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
  //   print("Accepted permission: $accepted");
  // });
  //
  // await OneSignal.shared.setAppId("95e65145-2b37-4da7-aa7d-d3a540a418b9");
  //
  // await OneSignal.shared
  //     .getDeviceState()
  //     .then((value) => {print(value!.userId)});
  //
  // OneSignal.shared.setNotificationWillShowInForegroundHandler(
  //         (OSNotificationReceivedEvent event) {
  //       // Will be called whenever a notification is received in foreground
  //       // Display Notification, pass null param for not displaying the notification
  //       event.complete(event.notification);
  //     });

  flutterToast = Fluttertoast();
  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("_firebaseMessagingBackgroundHandler: $message");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      home: const SplashPage(),
    );
  }
}
