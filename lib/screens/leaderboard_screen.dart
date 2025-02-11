// screens/leaderboard_screen.dart
import 'package:flutter/material.dart';
import '../models/leaderboard_model.dart';

class LeaderboardScreen extends StatelessWidget {
  final List<LeaderboardEntry> entries;

  LeaderboardScreen({required this.entries});

  @override
  Widget build(BuildContext context) {
    entries.sort((a, b) => b.totalScore.compareTo(a.totalScore));

    return Scaffold(
      appBar: AppBar(title: Text('Leaderboard')),
      body: ListView.builder(
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(entries[index].username),
            trailing: Text(entries[index].totalScore.toString()),
          );
        },
      ),
    );
  }
}
