// screens/login_screen.dart
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/statistics_model.dart';
import '../models/level_model.dart';
import '../models/badge_model.dart' as custom_badge;

class LoginScreen extends StatefulWidget {
  final Function(User) onLogin;

  LoginScreen({required this.onLogin});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();

  void _login() {
    // Mock user data for simplicity
    final user = User(
      username: _usernameController.text,
      email: 'user@example.com',
      subjectScores: {'Math': [], 'Science': [], 'History': []},
      statistics: Statistics(totalQuizzes: 0, totalCorrectAnswers: 0, totalQuestions: 0, averageScore: 0.0),
      badges: [
        custom_badge.Badge(name: 'Quiz Master', description: 'Complete 10 quizzes'),
        // Add more badges as needed
      ],
      level: Level(level: 1, experiencePoints: 0, experienceRequired: 100),
    );

    widget.onLogin(user);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
