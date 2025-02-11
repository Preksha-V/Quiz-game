// screens/badges_screen.dart
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class BadgesScreen extends StatelessWidget {
  final User user;

  BadgesScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Badges')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: user.badges.map((badge) {
            return ListTile(
              title: Text(badge.name),
              subtitle: Text(badge.description),
              trailing: Icon(badge.earned ? Icons.check : Icons.lock),
            );
          }).toList(),
        ),
      ),
    );
  }
}
