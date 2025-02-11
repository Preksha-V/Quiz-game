// screens/statistics_screen.dart
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class StatisticsScreen extends StatelessWidget {
  final User user;

  StatisticsScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Total Quizzes: ${user.statistics.totalQuizzes}'),
            Text('Total Correct Answers: ${user.statistics.totalCorrectAnswers}'),
            Text('Total Questions: ${user.statistics.totalQuestions}'),
            Text('Average Score: ${user.statistics.averageScore.toStringAsFixed(2)}%'),
          ],
        ),
      ),
    );
  }
}
