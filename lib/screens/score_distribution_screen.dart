// screens/score_distribution_screen.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/user_model.dart';

class ScoreDistributionScreen extends StatelessWidget {
  final List<User> users;

  ScoreDistributionScreen({required this.users});

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> _generateSections() {
      Map<String, int> scoreRanges = {
        '0-50%': 0,
        '51-70%': 0,
        '71-90%': 0,
        '91-100%': 0,
      };

      users.forEach((user) {
        double averageScore = user.statistics.averageScore;
        if (averageScore <= 50) {
          scoreRanges['0-50%'] = (scoreRanges['0-50%'] ?? 0) + 1;
        } else if (averageScore <= 70) {
          scoreRanges['51-70%'] = (scoreRanges['51-70%'] ?? 0) + 1;
        } else if (averageScore <= 90) {
          scoreRanges['71-90%'] = (scoreRanges['71-90%'] ?? 0) + 1;
        } else if (averageScore <= 100) {
          scoreRanges['91-100%'] = (scoreRanges['91-100%'] ?? 0) + 1;
        }
      });

      return scoreRanges.entries.where((entry) => entry.value > 0).map((entry) {
        return PieChartSectionData(
          value: entry.value.toDouble(),
          title: '${entry.key}: ${entry.value}',
        );
      }).toList();
    }

    return Scaffold(
      appBar: AppBar(title: Text('Score Distribution')),
      body: Center(
        child: PieChart(
          PieChartData(sections: _generateSections()),
        ),
      ),
    );
  }
}
