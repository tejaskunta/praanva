import 'package:flutter/material.dart';
import 'dart:async';

// ths is where we display the exercise for the stress level of the stdent
class ExerciseScreen extends StatefulWidget {
  final String exerciseType;
  final String stressLevel;

  const ExerciseScreen({
    super.key,
    required this.exerciseType,
    required this.stressLevel,
  });

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen>
    with SingleTickerProviderStateMixin {
  // Custom colors for the app theme
  final Color _primaryColor = const Color(0xFF6B4EFF);
  final Color _secondaryColor = const Color(0xFFE8E0FF);
  final Color _textColor = const Color(0xFF2D1B69);

  // Animation controller for breathing circle
  late final AnimationController _breathController;
  late final Animation<double> _breathAnimation;

  // State variables
  bool _isActive = false;
  Timer? _exerciseTimer;
  int _timeLeft = 0;
  int _maxTime = 0;
  bool _showHelp = true;

  @override
  void initState() {
    super.initState();
    // Initialize animation controller first
    _breathController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    // Initialize animation after controller
    _breathAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _breathController,
        curve: Curves.easeInOut,
      ),
    );

    _initializeExercise();
  }

  void _initializeExercise() {
    try {
      // Set duration based on exercise type
      switch (widget.exerciseType) {
        case 'Deep Breathing':
          _maxTime = 300; // 5 min
          break;
        case 'Grounding Techniques':
          _maxTime = 180; // 3 min
          break;
        case 'Positive Affirmations':
          _maxTime = 240; // 4 min
          break;
        case 'Light Breathing':
          _maxTime = 180; // 3 min
          break;
        case 'Diaphragmatic Breathing':
          _maxTime = 240; // 4 min
          break;
        case 'Guided Meditation':
          _maxTime = 300; // 5 min
          break;
        default:
          _maxTime = 180; // Default 3 min
      }
      _timeLeft = _maxTime;
    } catch (e) {
      debugPrint('Error initializing exercise: $e');
      _maxTime = 180;
      _timeLeft = 180;
    }
  }

  void _startExercise() {
    if (_timeLeft <= 0) return; // Prevent starting if time is up

    setState(() {
      _isActive = true;
      _showHelp = false;
    });

    _breathController.repeat(reverse: true);

    _exerciseTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _stopExercise();
        }
      });
    });
  }

  void _stopExercise() {
    setState(() {
      _isActive = false;
    });
    _exerciseTimer?.cancel();
    _breathController.stop();
  }

  void _resetExercise() {
    setState(() {
      _timeLeft = _maxTime;
      _isActive = false;
      _showHelp = true;
    });
    _exerciseTimer?.cancel();
    _breathController.stop();
  }

  @override
  void dispose() {
    _breathController.dispose();
    _exerciseTimer?.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Widget _buildExerciseContent() {
    switch (widget.exerciseType) {
      case 'Deep Breathing':
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _breathAnimation,
              child: Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.air,
                  size: 80,
                  color: _primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              _isActive ? 'Breathe Out' : 'Breathe In',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _textColor,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Take deep breaths in through your nose\nand out through your mouth',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: _textColor,
              ),
            ),
          ],
        );

      case 'Grounding Techniques':
        return Container(
          width: 250,
          height: 250,
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                _secondaryColor,
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _primaryColor,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${(_maxTime - _timeLeft) ~/ 30 + 1}/5',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: _textColor,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                _getGroundingStep(_timeLeft),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _textColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Take your time with each step',
                style: TextStyle(
                  fontSize: 14,
                  color: _textColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );

      case 'Positive Affirmations':
        return Container(
          width: 250,
          height: 250,
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                _secondaryColor,
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _primaryColor,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite,
                size: 40,
                color: _textColor,
              ),
              const SizedBox(height: 16),
              Text(
                _getAffirmation(_timeLeft),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _textColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Repeat this affirmation to yourself',
                style: TextStyle(
                  fontSize: 14,
                  color: _textColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );

      case 'Light Breathing':
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _breathAnimation,
              child: Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.air,
                  size: 80,
                  color: _primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              _isActive ? 'Breathe Out' : 'Breathe In',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _textColor,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Take gentle breaths in and out\nat a comfortable pace',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: _textColor,
              ),
            ),
          ],
        );

      case 'Diaphragmatic Breathing':
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _breathAnimation,
              child: Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.self_improvement,
                  size: 80,
                  color: _primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              _isActive ? 'Breathe Out' : 'Breathe In',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _textColor,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Place your hand on your belly\nand feel it rise and fall',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: _textColor,
              ),
            ),
          ],
        );

      case 'Guided Meditation':
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Background circle
                  Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _primaryColor,
                        width: 2,
                      ),
                    ),
                  ),
                  // Progress circle
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: CircularProgressIndicator(
                      value: 1 - (_timeLeft / _maxTime),
                      strokeWidth: 30,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      valueColor: AlwaysStoppedAnimation<Color>(_primaryColor),
                    ),
                  ),
                  // Center content
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.self_improvement,
                        size: 50,
                        color: _primaryColor,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _getMeditationPhase(_timeLeft),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Phase ${(_maxTime - _timeLeft) ~/ 60 + 1}/5',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _textColor,
              ),
            ),
          ],
        );

      default:
        return const Center(
          child: Text('Exercise type not found'),
        );
    }
  }

  String _getGroundingStep(int remainingSeconds) {
    final steps = [
      'Notice 5 things you can see',
      'Touch 4 things you can feel',
      'Listen for 3 things you can hear',
      'Smell 2 things you can smell',
      'Taste 1 thing you can taste',
    ];
    return steps[(_maxTime - remainingSeconds) ~/ 30];
  }

  String _getAffirmation(int remainingSeconds) {
    final affirmations = [
      'I am strong and capable',
      'I choose to be calm and peaceful',
      'I trust in my ability to handle challenges',
      'I am worthy of love and respect',
      'I have the power to create positive change',
      'I am grateful for this moment',
    ];
    return affirmations[(_maxTime - remainingSeconds) ~/ 40];
  }

  String _getMeditationPhase(int remainingSeconds) {
    final phases = [
      'Find comfort and close your eyes',
      'Focus on your breath',
      'Let thoughts come and go',
      'Return to your breath',
      'Feel gratitude and peace',
    ];
    final phaseIndex = (_maxTime - remainingSeconds) ~/ 60;
    return phases[phaseIndex.clamp(0, 4)]; // Ensure index is between 0 and 4
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exerciseType),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              _primaryColor,
              _secondaryColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Center(
                    child: _buildExerciseContent(),
                  ),
                ),
                if (_showHelp)
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
                          'Instructions',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: _textColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _getExerciseInstructions(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: _textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 20),
                Text(
                  _formatTime(_timeLeft),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _textColor,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _resetExercise,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primaryColor,
                        foregroundColor: _textColor,
                      ),
                      child: const Text('Reset'),
                    ),
                    ElevatedButton(
                      onPressed: _isActive ? _stopExercise : _startExercise,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _textColor,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(_isActive ? 'Stop' : 'Start'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getExerciseInstructions() {
    switch (widget.exerciseType) {
      case 'Deep Breathing':
        return 'Take deep, slow breaths in through your nose and out through your mouth. Focus on expanding your chest and belly as you breathe in, and letting go of tension as you breathe out.';
      case 'Grounding Techniques':
        return 'Follow the prompts to engage your senses and bring your attention to the present moment. This helps reduce anxiety and stress by focusing on your immediate surroundings.';
      case 'Positive Affirmations':
        return 'Listen to each affirmation and repeat it to yourself. Focus on believing and feeling the truth of each statement. This helps build positive self-talk and resilience.';
      case 'Light Breathing':
        return 'Take gentle, natural breaths at a comfortable pace. Focus on maintaining a steady rhythm without forcing or straining. This helps promote relaxation and calm.';
      case 'Diaphragmatic Breathing':
        return 'Place one hand on your chest and one on your belly. Breathe deeply, focusing on expanding your belly as you inhale and letting it fall as you exhale. This helps reduce tension and promote relaxation.';
      case 'Guided Meditation':
        return 'Find a comfortable position and follow the guided meditation phases. Focus on your breath and let thoughts come and go without judgment. This helps promote mindfulness and reduce stress.';
      default:
        return 'Follow the on-screen instructions to complete the exercise.';
    }
  }
}
