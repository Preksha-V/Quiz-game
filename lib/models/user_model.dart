// models/user_model.dart
import 'statistics_model.dart';
import 'badge_model.dart';
import 'level_model.dart';

class User {
  String username;
  String email;
  Map<String, List<int>> subjectScores;
  Statistics statistics;
  List<Badge> badges;
  Level level;

  User({required this.username, required this.email, required this.subjectScores, required this.statistics, required this.badges, required this.level});
}
