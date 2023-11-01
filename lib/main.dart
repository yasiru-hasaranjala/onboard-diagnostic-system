import 'package:flutter/material.dart';
import 'package:bike/modules/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bike/modules/login/login.dart';
import 'package:bike/modules/menu/menu.dart';
import 'package:bike/modules/signup/signup.dart';

import 'modules/history/history.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey:'AIzaSyAhFdTQbYI0EYtjZA9KDJzMCqQBm3x75tM',
        appId:'1:86802414269:android:5ffe50defbf4d3263555d4',
        messagingSenderId:'86802414269',
        projectId:'obdsystem-785a5',
        databaseURL: 'https://obdsystem-785a5-default-rtdb.firebaseio.com/'
      )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(),
      initialRoute: 'welcome_screen',
      routes: {
        'welcome_screen': (context) => const HomeScreen(),
        'registration_screen': (context) => const SignUpScreen(),
        'login_screen': (context) => const LoginScreen(),
        'home_screen': (context) => const Menu(),
        'history_screen': (context) => const History(),
      },
    );
  }
}
