// screens/result_screen.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ResultScreen extends StatelessWidget {
  final Map<String, int> subjectScores;

  ResultScreen({required this.subjectScores});

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> _generateSections() {
      List<PieChartSectionData> sections = [];
      int totalScore = subjectScores.values.reduce((a, b) => a + b);

      subjectScores.forEach((subject, score) {
        double percentage = (score / totalScore) * 100;
        sections.add(PieChartSectionData(
          color: subject == 'Math' ? Colors.blue : subject == 'Science' ? Colors.green : Colors.red,
          value: percentage,
          title: '$subject: ${percentage.toStringAsFixed(1)}%',
        ));
      });
      return sections;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: _generateSections(),
                  centerSpaceRadius: 40,
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the home screen
              },
              child: Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
