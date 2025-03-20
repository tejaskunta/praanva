import 'package:flutter/material.dart';
import 'stress_result_screen.dart';

class Question {
  final String text;
  final List<String> options;
  final List<int> scores;

  Question({
    required this.text,
    required this.options,
    required this.scores,
  });
}

final List<Question> allQuestions = [
  Question(
    text: 'In your daily tasks, do you often feel overwhelmed or swamped?',
    options: ['Rarely', 'Sometimes', 'Often', 'Almost daily'],
    scores: [1, 2, 3, 4],
  ),
  Question(
    text: 'When plans change suddenly, what\'s your usual reaction?',
    options: [
      'Adjust calmly',
      'Mildly stressed',
      'Feel unsettled',
      'Feel out of control'
    ],
    scores: [1, 2, 3, 4],
  ),
  Question(
    text:
        'Physical symptoms like headaches or body tension — do they show up regularly?',
    options: ['Never', 'Occasionally', 'Regularly', 'Almost every day'],
    scores: [1, 2, 3, 4],
  ),
  Question(
    text: 'Deadlines approaching — do they keep you calm or cause distress?',
    options: [
      'Stay composed',
      'Slightly uneasy',
      'Feel pressure',
      'Completely stressed'
    ],
    scores: [1, 2, 3, 4],
  ),
  Question(
    text: 'Describe your typical sleep quality at night.',
    options: [
      'Very restful',
      'Somewhat light',
      'Difficulty falling asleep',
      'Restless and anxious'
    ],
    scores: [1, 2, 3, 4],
  ),
  Question(
    text: 'Do you catch yourself getting irritated for no clear reason?',
    options: ['Rarely', 'Occasionally', 'Often', 'Nearly all the time'],
    scores: [1, 2, 3, 4],
  ),
  Question(
    text: 'Are personal challenges manageable or overwhelming for you?',
    options: ['Absolutely', 'Most of the time', 'Not usually', 'Never'],
    scores: [1, 2, 3, 4],
  ),
  Question(
    text:
        'Feeling nervous or uneasy without reason — how often does that happen?',
    options: ['Almost never', 'Sometimes', 'Quite often', 'Constantly'],
    scores: [1, 2, 3, 4],
  ),
  Question(
    text: 'When conflict arises, how do you tend to react?',
    options: [
      'Stay logical',
      'Avoid it',
      'Become defensive',
      'React impulsively'
    ],
    scores: [1, 2, 3, 4],
  ),
  Question(
    text: 'Do problems pile up until they feel impossible to solve?',
    options: ['Never', 'Occasionally', 'Frequently', 'Always'],
    scores: [1, 2, 3, 4],
  ),
  Question(
    text:
        'How often do you make time for relaxation activities like yoga or meditation?',
    options: ['Daily', 'Weekly', 'Rarely', 'Never'],
    scores: [1, 2, 3, 4],
  ),
  Question(
    text: 'Does your daily routine ever feel pointless or meaningless?',
    options: ['Never', 'At times', 'Frequently', 'Almost always'],
    scores: [1, 2, 3, 4],
  ),
];

class StressAssessmentScreen extends StatefulWidget {
  const StressAssessmentScreen({super.key});

  @override
  State<StressAssessmentScreen> createState() => _StressAssessmentScreenState();
}

class _StressAssessmentScreenState extends State<StressAssessmentScreen> {
  final List<Question> _selectedQuestions = [];
  int _currentIndex = 0;
  int _totalScore = 0;
  final List<int> _scoreHistory = [];

  @override
  void initState() {
    super.initState();
    allQuestions.shuffle();
    _selectedQuestions.addAll(allQuestions.take(11));
  }

  void _answerQuestion(int score) {
    setState(() {
      _scoreHistory.add(score);
      _totalScore += score;
    });

    if (_currentIndex < _selectedQuestions.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      // Calculate stress level based on total score
      String stressLevel;
      if (_totalScore <= 12) {
        stressLevel = 'Low';
      } else if (_totalScore <= 24) {
        stressLevel = 'Moderate';
      } else if (_totalScore <= 36) {
        stressLevel = 'High';
      } else {
        stressLevel = 'Very High';
      }

      // Determine exercise type based on stress level
      String exerciseType;
      switch (stressLevel) {
        case 'Low':
          exerciseType = 'Positive Affirmations';
          break;
        case 'Moderate':
          exerciseType = 'Grounding Techniques';
          break;
        case 'High':
          exerciseType = 'Deep Breathing';
          break;
        case 'Very High':
          exerciseType = 'Progressive Muscle Relaxation';
          break;
        default:
          exerciseType = 'Light Breathing';
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => StressResultScreen(
            score: _totalScore,
            description: _getStressDescription(_totalScore),
            stressLevel: stressLevel,
            exerciseType: exerciseType,
          ),
        ),
      );
    }
  }

  void _previousQuestion() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _totalScore -= _scoreHistory.removeLast();
      });
    }
  }

  String _getStressLevel(int score) {
    if (score <= 24) return 'Low';
    if (score <= 36) return 'Moderate';
    return 'High';
  }

  String _getStressDescription(int score) {
    if (score <= 24) {
      return 'You\'re managing stress well. Keep up your healthy habits and self-care routines.';
    } else if (score <= 36) {
      return 'You\'re experiencing moderate stress. Consider incorporating more stress management techniques into your daily routine.';
    } else {
      return 'You\'re experiencing high levels of stress. It\'s important to take steps to manage your stress and consider talking to a professional.';
    }
  }

  Widget _buildAnswerButton(String text, int value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _scoreHistory.add(value);
            _totalScore += value;
          });

          if (_currentIndex < _selectedQuestions.length - 1) {
            setState(() {
              _currentIndex++;
            });
          } else {
            // Calculate stress level based on total score
            String stressLevel;
            if (_totalScore <= 12) {
              stressLevel = 'Low';
            } else if (_totalScore <= 24) {
              stressLevel = 'Moderate';
            } else if (_totalScore <= 36) {
              stressLevel = 'High';
            } else {
              stressLevel = 'Very High';
            }

            // Determine exercise type based on stress level
            String exerciseType;
            switch (stressLevel) {
              case 'Low':
                exerciseType = 'Positive Affirmations';
                break;
              case 'Moderate':
                exerciseType = 'Grounding Techniques';
                break;
              case 'High':
                exerciseType = 'Deep Breathing';
                break;
              case 'Very High':
                exerciseType = 'Progressive Muscle Relaxation';
                break;
              default:
                exerciseType = 'Light Breathing';
            }

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => StressResultScreen(
                  score: _totalScore,
                  description: _getStressDescription(_totalScore),
                  stressLevel: stressLevel,
                  exerciseType: exerciseType,
                ),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.purple[700],
          padding: const EdgeInsets.symmetric(vertical: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.purple[700]!),
          ),
          elevation: 2,
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stress Assessment',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 4,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.purple[700]!.withOpacity(0.8),
                Colors.purple[700]!.withOpacity(0.6),
              ],
            ),
          ),
        ),
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
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Progress Indicator
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withAlpha(26),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      LinearProgressIndicator(
                        value: (_currentIndex + 1) / _selectedQuestions.length,
                        backgroundColor: Colors.purple[100],
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.purple[700]!),
                        minHeight: 8,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Question ${_currentIndex + 1} of ${_selectedQuestions.length}',
                        style: TextStyle(
                          color: Colors.purple[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Question Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withAlpha(26),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Text(
                    _selectedQuestions[_currentIndex].text,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.purple[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),

                // Answer Options
                ..._selectedQuestions[_currentIndex]
                    .options
                    .asMap()
                    .entries
                    .map((entry) {
                  int index = entry.key;
                  String option = entry.value;
                  return _buildAnswerButton(
                      option, _selectedQuestions[_currentIndex].scores[index]);
                }).toList(),

                const Spacer(),

                // Navigation Buttons
                Row(
                  children: [
                    if (_currentIndex > 0)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.purple[700],
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.purple[700]!),
                          ),
                          elevation: 2,
                        ),
                        onPressed: _previousQuestion,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.arrow_back,
                              color: Colors.purple[700],
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Previous',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
