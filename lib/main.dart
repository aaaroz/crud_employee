import 'package:crud_employee/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue, primaryColor: Colors.blueAccent),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
