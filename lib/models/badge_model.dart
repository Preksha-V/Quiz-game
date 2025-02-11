// models/badge_model.dart
class Badge {
  String name;
  String description;
  bool earned;

  Badge({required this.name, required this.description, this.earned = false});
}
