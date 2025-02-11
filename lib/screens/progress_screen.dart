// screens/progress_screen.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/user_model.dart';

class ProgressScreen extends StatelessWidget {
  final User user;

  ProgressScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    List<LineChartBarData> _generateLineData() {
      List<LineChartBarData> lines = [];

      user.subjectScores.forEach((subject, scores) {
        List<FlSpot> spots = scores.asMap().entries.map((entry) {
          int index = entry.key;
          int score = entry.value;
          return FlSpot(index.toDouble(), score.toDouble());
        }).toList();

        lines.add(LineChartBarData(
          spots: spots,
          isCurved: true,
          barWidth: 4,
          colors: [subject == 'Math' ? Colors.blue : subject == 'Science' ? Colors.green : Colors.red],
          dotData: FlDotData(show: true),
        ));
      });

      return lines;
    }

    return Scaffold(
      appBar: AppBar(title: Text('Progress')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LineChart(
            LineChartData(
              lineBarsData: _generateLineData(),
              gridData: FlGridData(show: true),
              titlesData: FlTitlesData(
                leftTitles: SideTitles(showTitles: true),
                bottomTitles: SideTitles(showTitles: true),
              ),
              borderData: FlBorderData(show: true),
            ),
          ),
        ),
      ),
    );
  }
}

