// models/question_model.dart
class Question {
  String questionText;
  List<String> answers;
  int correctAnswerIndex;

  Question({required this.questionText, required this.answers, required this.correctAnswerIndex});
}
