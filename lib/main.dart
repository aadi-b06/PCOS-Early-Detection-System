import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';

void main() {
  runApp(PCOSApp());
}

class PCOSApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "PCOS Health App",
      theme: ThemeData(primarySwatch: Colors.deepPurple),

      // 👇 START FROM LOGIN SCREEN
      initialRoute: "/",

      routes: {
        "/": (context) => LoginScreen(),
        "/signup": (context) => SignupScreen(),
      },
    );
  }
}