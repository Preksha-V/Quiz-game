// screens/level_screen.dart
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class LevelScreen extends StatelessWidget {
  final User user;

  LevelScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Level')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Level: ${user.level.level}'),
            Text('Experience Points: ${user.level.experiencePoints} / ${user.level.experienceRequired}'),
          ],
        ),
      ),
    );
  }
}
