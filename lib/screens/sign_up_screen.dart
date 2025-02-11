// screens/sign_up_screen.dart
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/statistics_model.dart';
import '../models/level_model.dart';
import '../models/badge_model.dart' as custom_badge;

class SignUpScreen extends StatefulWidget {
  final Function(User) onSignUp;

  SignUpScreen({required this.onSignUp});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();

  void _signUp() {
    final user = User(
      username: _usernameController.text,
      email: _emailController.text,
      subjectScores: {'Math': [], 'Science': [], 'History': []},
      statistics: Statistics(totalQuizzes: 0, totalCorrectAnswers: 0, totalQuestions: 0, averageScore: 0.0),
      badges: [
        custom_badge.Badge(name: 'Quiz Master', description: 'Complete 10 quizzes'),
        // Add more badges as needed
      ],
      level: Level(level: 1, experiencePoints: 0, experienceRequired: 100),
    );

    widget.onSignUp(user);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signUp,
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
