import 'package:flutter/material.dart';
import 'package:bike/modules/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bike/modules/login/login.dart';
import 'package:bike/modules/menu/menu.dart';
import 'package:bike/modules/signup/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey:'AIzaSyDBS49PmjQScSWTVMCn5Da_NC1r91VdrVc',
        appId:'1:75631826544:android:bf3de325af253541bec6b5',
        messagingSenderId:'75631826544',
        projectId:'onboard-diagnostic-system',
        databaseURL: 'https://onboard-diagnostic-system-default-rtdb.asia-southeast1.firebasedatabase.app/'
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
      },
    );
  }
}
