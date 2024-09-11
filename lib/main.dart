import 'package:flutter/material.dart';
import 'package:food_app_project/routes/routes.dart';
import 'package:food_app_project/screen/splash_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

Fluttertoast? flutterToast;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  flutterToast = Fluttertoast();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Order App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      routes: routes,
      home: const SplashPage(),
    );
  }
}
