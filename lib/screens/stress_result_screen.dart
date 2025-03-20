import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'chat_room_screen.dart';
import 'exercise_screen.dart';

class StressResultScreen extends StatelessWidget {
  final int score;
  final String description;
  final String stressLevel;
  final String exerciseType;

  const StressResultScreen({
    super.key,
    required this.score,
    required this.description,
    required this.stressLevel,
    required this.exerciseType,
  });

  //stress info the student could have
  Map<String, dynamic> _getStressInfo() {
    switch (stressLevel) {
      case 'Low':
        return {
          'color': Colors.green,
          'exercises': [
            {
              'name': 'Positive Affirmations',
              'description':
                  'Practice positive self-talk to maintain your well-being.',
              'icon': Icons.self_improvement,
            },
            {
              'name': 'Light Breathing',
              'description':
                  'Gentle breathing exercises to maintain calm and balance.',
              'icon': Icons.air,
            },
          ],
          'description':
              'You\'re managing stress well. Keep up the good work and maintain your healthy habits.',
        };
      case 'Moderate':
        return {
          'color': Colors.orange,
          'exercises': [
            {
              'name': 'Grounding Techniques',
              'description':
                  'Use grounding exercises to manage moderate stress levels.',
              'icon': Icons.landscape,
            },
            {
              'name': 'Diaphragmatic Breathing',
              'description':
                  'Deep belly breathing to reduce tension and promote relaxation.',
              'icon': Icons.self_improvement,
            },
          ],
          'description':
              'You\'re experiencing moderate stress. Consider incorporating more stress management techniques into your daily routine.',
        };
      case 'High':
        return {
          'color': Colors.red,
          'exercises': [
            {
              'name': 'Deep Breathing',
              'description':
                  'Practice deep breathing to reduce high stress levels.',
              'icon': Icons.air,
            },
            {
              'name': 'Guided Meditation',
              'description':
                  'Follow guided meditation sessions to find calm and clarity.',
              'icon': Icons.self_improvement,
            },
          ],
          'description':
              'You\'re experiencing high levels of stress. It\'s important to take steps to manage your stress and consider talking to a professional.',
          'hotlines': [
            {
              'name': 'National Crisis Hotline',
              'number': '988',
              'description': '24/7 support for mental health crises',
            },
          ],
        };
      case 'Very High':
        return {
          'color': Colors.red[900],
          'exercises': [
            {
              'name': 'Deep Breathing',
              'description':
                  'Practice deep breathing to reduce high stress levels.',
              'icon': Icons.air,
            },
            {
              'name': 'Guided Meditation',
              'description':
                  'Follow guided meditation sessions to find calm and clarity.',
              'icon': Icons.self_improvement,
            },
          ],
          'description':
              'You\'re experiencing very high levels of stress. Please reach out to a mental health professional immediately. You don\'t have to face this alone.',
          'hotlines': [
            {
              'name': 'National Crisis Hotline',
              'number': '988',
              'description': '24/7 support for mental health crises',
            },
            {
              'name': 'Emergency Services',
              'number': '911',
              'description': 'For immediate emergency assistance',
            },
          ],
        };
      default:
        return {
          'color': Colors.grey,
          'exercises': [
            {
              'name': 'Positive Affirmations',
              'description': 'Try some general stress relief exercises.',
              'icon': Icons.self_improvement,
            },
            {
              'name': 'Light Breathing',
              'description':
                  'Gentle breathing exercises for overall well-being.',
              'icon': Icons.air,
            },
          ],
          'description': 'Try some general stress relief exercises.',
        };
    }
  }

  // this is actual widget that akes the app run rom the stress result on top
  @override
  Widget build(BuildContext context) {
    final stressInfo = _getStressInfo();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stress Assessor'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purple[50]!,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Stress Level Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Your Stress Level',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[700],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          height: 200,
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: LineChart(
                            LineChartData(
                              gridData: const FlGridData(show: false),
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 40,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.toInt().toString(),
                                        style: TextStyle(
                                          color: Colors.purple[700],
                                          fontSize: 12,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      const days = [
                                        'Mon',
                                        'Tue',
                                        'Wed',
                                        'Thu',
                                        'Fri',
                                        'Sat',
                                        'Sun',
                                        'Mon',
                                        'Tue'
                                      ];
                                      if (value.toInt() >= 0 &&
                                          value.toInt() < days.length) {
                                        return Text(
                                          days[value.toInt()],
                                          style: TextStyle(
                                            color: Colors.purple[700],
                                            fontSize: 12,
                                          ),
                                        );
                                      }
                                      return const Text('');
                                    },
                                  ),
                                ),
                              ),
                              borderData: FlBorderData(show: false),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: [
                                    const FlSpot(0, 3),
                                    const FlSpot(1, 4),
                                    const FlSpot(2, 2),
                                    const FlSpot(3, 5),
                                    const FlSpot(4, 3),
                                    const FlSpot(5, 4),
                                    const FlSpot(6, 3),
                                    const FlSpot(7, 4),
                                    const FlSpot(8, 2),
                                  ],
                                  isCurved: true,
                                  color: Colors.purple[700],
                                  barWidth: 3,
                                  isStrokeCapRound: true,
                                  dotData: const FlDotData(show: true),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: Colors.purple[100]!.withOpacity(0.3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          stressLevel,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[700],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Stress Score: ${((score / 48) * 100).round()}%',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // recommended exercises for stuent
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recommended Exercises',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[700],
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...stressInfo['exercises']
                            .map<Widget>((exercise) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ExerciseScreen(
                                            exerciseType: exercise['name'],
                                            stressLevel: stressLevel,
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.purple[700],
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        side: BorderSide(
                                            color: Colors.purple[700]!),
                                      ),
                                      elevation: 2,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          exercise['icon'],
                                          color: Colors.purple[700],
                                          size: 32,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                exercise['name'],
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.purple[700],
                                                ),
                                              ),
                                              Text(
                                                exercise['description'],
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.purple[700],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Hotlines Card (if available)
                  if (stressInfo['hotlines'] != null) ...[
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Emergency Hotlines',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple[700],
                            ),
                          ),
                          const SizedBox(height: 16),
                          ...stressInfo['hotlines']
                              .map<Widget>((hotline) => Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.red[50],
                                        borderRadius: BorderRadius.circular(12),
                                        border:
                                            Border.all(color: Colors.red[200]!),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            hotline['name'],
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red[700],
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            hotline['number'],
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red[900],
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            hotline['description'],
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.red[700],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Description Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'What This Means',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[700],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          stressInfo['description'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.purple[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Talk to Therapist Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChatRoomScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[700],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: const Text(
                      'Talk to a Therapist',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
