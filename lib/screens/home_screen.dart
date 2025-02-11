// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'sign_up_screen.dart';
import 'login_screen.dart';
import '../models/user_model.dart';
import '../models/leaderboard_model.dart';
import '../models/statistics_model.dart';
import '../models/level_model.dart';
import 'exam_screen.dart';
import 'result_screen.dart';
import 'progress_screen.dart';
import 'leaderboard_screen.dart';
import 'statistics_screen.dart';
import 'score_distribution_screen.dart';
import 'badges_screen.dart';
import 'level_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? _currentUser;
  List<LeaderboardEntry> leaderboardEntries = [];

  void _signUp(User user) {
    setState(() {
      _currentUser = user;
    });
  }

  void _login(User user) {
    setState(() {
      _currentUser = user;
    });
  }

  void _logout() {
    setState(() {
      _currentUser = null;
    });
  }

  void _navigateToExamScreen(String subject) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExamScreen(subject: subject, onScoreUpdate: (score) {
          setState(() {
            _currentUser?.subjectScores[subject]?.add(score);
            int totalScore = _currentUser!.subjectScores.values
                .expand((scores) => scores)
                .reduce((a, b) => a + b);
            leaderboardEntries.add(LeaderboardEntry(username: _currentUser!.username, totalScore: totalScore));
          });
        }),
      ),
    ).then((_) {
      // Check if all subjects have been completed
      if (_currentUser?.subjectScores.values.every((scores) => scores.isNotEmpty) ?? false) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(subjectScores: _currentUser!.subjectScores.map((subject, scores) => MapEntry(subject, scores.reduce((a, b) => a + b)))),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Online Exam App'),
        actions: [
          if (_currentUser != null)
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: _logout,
            ),
        ],
      ),
      body: Center(
        child: _currentUser == null ? _buildAuthButtons() : _buildQuizOptions(),
      ),
    );
  }

  Widget _buildAuthButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignUpScreen(onSignUp: _signUp),
              ),
            );
          },
          child: Text('Sign Up'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(onLogin: _login),
              ),
            );
          },
          child: Text('Login'),
        ),
      ],
    );
  }

  Widget _buildQuizOptions() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => _navigateToExamScreen('Math'),
          child: Text('Math Quiz'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => _navigateToExamScreen('Science'),
          child: Text('Science Quiz'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => _navigateToExamScreen('History'),
          child: Text('History Quiz'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProgressScreen(user: _currentUser!),
              ),
            );
          },
          child: Text('View Progress'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LeaderboardScreen(entries: leaderboardEntries),
              ),
            );
          },
          child: Text('Leaderboard'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StatisticsScreen(user: _currentUser!),
              ),
            );
          },
          child: Text('View Statistics'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScoreDistributionScreen(users: _getAllUsers()),
              ),
            );
          },
          child: Text('Score Distribution'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BadgesScreen(user: _currentUser!),
              ),
            );
          },
          child: Text('Badges'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LevelScreen(user: _currentUser!),
              ),
            );
          },
          child: Text('Level'),
        ),
      ],
    );
  }

  List<User> _getAllUsers() {
    // Mock data for simplicity
    return [
      User(
        username: 'User1',
        email: 'user1@example.com',
        subjectScores: {'Math': [80, 90], 'Science': [85], 'History': [78, 92]},
        statistics: Statistics(totalQuizzes: 5, totalCorrectAnswers: 425, totalQuestions: 500, averageScore: 85.0),
        badges: [],
        level: Level(level: 5, experiencePoints: 100, experienceRequired: 200),
      ),
      User(
        username: 'User2',
        email: 'user2@example.com',
        subjectScores: {'Math': [65, 70], 'Science': [75], 'History': [60, 82]},
        statistics: Statistics(totalQuizzes: 5, totalCorrectAnswers: 352, totalQuestions: 500, averageScore: 70.4),
        badges: [],
        level: Level(level: 4, experiencePoints: 50, experienceRequired: 200),
      ),
      // Add more mock users as needed
    ];
  }
}
