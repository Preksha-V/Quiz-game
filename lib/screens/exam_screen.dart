// screens/exam_screen.dart
import 'package:flutter/material.dart';
import '../models/question_model.dart';
import 'dart:async';
import 'result_screen.dart';

class ExamScreen extends StatefulWidget {
  final String subject;
  final Function(int) onScoreUpdate;

  ExamScreen({required this.subject, required this.onScoreUpdate});

  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  late Timer _timer;
  int _remainingSeconds = 60; // Set timer duration in seconds
  bool _isTimerRunning = true;

  List<Question> _questions = [];

  @override
  void initState() {
    super.initState();
    _questions = _getQuestionsBySubject(widget.subject);
    _startTimer();
  }

  List<Question> _getQuestionsBySubject(String subject) {
    if (subject == 'Math') {
      return [
        Question(
          questionText: 'What is 5 + 3?',
          answers: ['6', '7', '8', '9'],
          correctAnswerIndex: 2,
        ),
        Question(
          questionText: 'What is 12 / 4?',
          answers: ['2', '3', '4', '5'],
          correctAnswerIndex: 1,
        ),
        Question(
          questionText: 'What is 7 * 6?',
          answers: ['42', '36', '48', '52'],
          correctAnswerIndex: 0,
        ),
        Question(
          questionText: 'What is the square root of 49?',
          answers: ['5', '6', '7', '8'],
          correctAnswerIndex: 2,
        ),
        Question(
          questionText: 'What is 15 - 7?',
          answers: ['7', '8', '9', '10'],
          correctAnswerIndex: 1,
        ),
      ];
    } else if (subject == 'Science') {
      return [
        Question(
          questionText: 'What planet is known as the Red Planet?',
          answers: ['Earth', 'Mars', 'Jupiter', 'Venus'],
          correctAnswerIndex: 1,
        ),
        Question(
          questionText: 'What is the chemical symbol for water?',
          answers: ['O2', 'H2O', 'CO2', 'NaCl'],
          correctAnswerIndex: 1,
        ),
        Question(
          questionText: 'What force keeps us on the ground?',
          answers: ['Magnetism', 'Gravity', 'Friction', 'Tension'],
          correctAnswerIndex: 1,
        ),
        Question(
          questionText: 'What gas do plants absorb from the atmosphere?',
          answers: ['Oxygen', 'Carbon Dioxide', 'Nitrogen', 'Hydrogen'],
          correctAnswerIndex: 1,
        ),
        Question(
          questionText: 'What is the process by which plants make their food?',
          answers: ['Photosynthesis', 'Respiration', 'Transpiration', 'Digestion'],
          correctAnswerIndex: 0,
        ),
      ];
    } else {
      return [
        Question(
          questionText: 'Who was the first President of the USA?',
          answers: ['Abraham Lincoln', 'George Washington', 'Thomas Jefferson', 'John Adams'],
          correctAnswerIndex: 1,
        ),
        Question(
          questionText: 'Which ancient civilization built the pyramids?',
          answers: ['Romans', 'Greeks', 'Egyptians', 'Aztecs'],
          correctAnswerIndex: 2,
        ),
        Question(
          questionText: 'Who wrote the "I Have a Dream" speech?',
          answers: ['John F. Kennedy', 'Martin Luther King Jr.', 'Malcolm X', 'Rosa Parks'],
          correctAnswerIndex: 1,
        ),
        Question(
          questionText: 'What war was fought between the North and South regions in the United States?',
          answers: ['World War I', 'World War II', 'The Civil War', 'The Revolutionary War'],
          correctAnswerIndex: 2,
        ),
        Question(
          questionText: 'What was the name of the ship that brought the Pilgrims to America in 1620?',
          answers: ['Mayflower', 'Santa Maria', 'Pinta', 'Nina'],
          correctAnswerIndex: 0,
        ),
      ];
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _isTimerRunning = false;
          timer.cancel();
          _endExam();
        }
      });
    });
  }

  void _endExam() {
    widget.onScoreUpdate(_score);
    Navigator.pop(context);
  }

  void _answerQuestion(int selectedIndex) {
    setState(() {
      if (selectedIndex == _questions[_currentQuestionIndex].correctAnswerIndex) {
        _score += 10;
      }
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        _isTimerRunning = false;
        _timer.cancel();
        _endExam();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.subject} Quiz'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_isTimerRunning)
            Text(
              'Time Remaining: $_remainingSeconds s',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          SizedBox(height: 20),
          if (_isTimerRunning)
            Text(
              _questions[_currentQuestionIndex].questionText,
              style: TextStyle(fontSize: 24),
            ),
          SizedBox(height: 20),
          if (_isTimerRunning)
            ..._questions[_currentQuestionIndex].answers.asMap().entries.map((entry) {
              int index = entry.key;
              String answer = entry.value;
              return ElevatedButton(
                onPressed: () => _answerQuestion(index),
                child: Text(answer),
              );
            }).toList(),
          if (!_isTimerRunning)
            ElevatedButton(
              onPressed: () {
                _endExam();
              },
              child: Text('View Results'),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
