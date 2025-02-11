import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(OnlineExamApp());
}

class OnlineExamApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Exam App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(), // Ensure that you are calling HomeScreen correctly
    );
  }
}
