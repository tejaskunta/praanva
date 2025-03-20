import 'package:flutter/material.dart';
import 'stress_assessment_screen.dart';
import 'chat_room_screen.dart';
import 'therapist_mode_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Praanva'),
        actions: [
          IconButton(
            icon: const Icon(Icons.medical_services),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TherapistModeScreen(),
                ),
              );
            },
            tooltip: 'Therapist Mode',
          ),
        ],
      ),
      drawer: _buildDrawer(context),
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
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Welcome Section
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withOpacity(0.15),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to,',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.purple[400],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Praanva',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[700],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Your Mental Wellness Companion',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.purple[600],
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Main Action Buttons
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withOpacity(0.15),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[700],
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const StressAssessmentScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple[700],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 32),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 2,
                          ),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.assessment,
                                size: 48,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Take Assessment',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Evaluate your current stress levels',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
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
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.purple[700],
                            padding: const EdgeInsets.symmetric(vertical: 32),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(color: Colors.purple[700]!),
                            ),
                            elevation: 2,
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.chat_bubble_outline,
                                color: Colors.purple[700],
                                size: 48,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Talk to Therapist',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple[700],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Connect with a mental health professional',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.purple[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Quick Tips Section
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withOpacity(0.15),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quick Tips',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[700],
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildTipCard(
                          'Practice Deep Breathing',
                          'Take slow, deep breaths to reduce stress and anxiety',
                          Icons.air,
                        ),
                        const SizedBox(height: 12),
                        _buildTipCard(
                          'Stay Active',
                          'Regular exercise helps manage stress levels',
                          Icons.fitness_center,
                        ),
                        const SizedBox(height: 12),
                        _buildTipCard(
                          'Get Enough Sleep',
                          'Quality sleep is essential for stress management',
                          Icons.bedtime,
                        ),
                      ],
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

  Widget _buildTipCard(String title, String description, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple[200]!),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.purple[700],
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple[700],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.purple[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.purple[700]!,
                  Colors.purple[500]!,
                ],
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.self_improvement,
                  size: 48,
                  color: Colors.white,
                ),
                SizedBox(height: 8),
                Text(
                  'Mental Health Resources',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ExpansionTile(
            leading: Icon(Icons.phone, color: Colors.purple[700]),
            title: const Text('Emergency Hotlines'),
            children: [
              _buildHotlineItem(
                'Vandrevala Foundation',
                '+91 1860 2662 345',
                Icons.phone,
              ),
              _buildHotlineItem(
                'NIMHANS',
                '+91 80 4611 0007',
                Icons.local_hospital,
              ),
              _buildHotlineItem(
                'Fortis Mental Health',
                '+91 8376 804 804',
                Icons.medical_services,
              ),
              _buildHotlineItem(
                'iCall',
                '+91 9152 987 654',
                Icons.psychology,
              ),
              _buildHotlineItem(
                'Emergency (112)',
                '112',
                Icons.emergency,
              ),
            ],
          ),
          ExpansionTile(
            leading: Icon(Icons.article, color: Colors.purple[700]),
            title: const Text('Mental Health Articles'),
            children: [
              _buildResourceItem(
                'Understanding Anxiety',
                'Learn about anxiety symptoms and coping strategies',
                Icons.psychology,
              ),
              _buildResourceItem(
                'Stress Management',
                'Effective techniques for managing daily stress',
                Icons.self_improvement,
              ),
              _buildResourceItem(
                'Sleep Hygiene',
                'Tips for better sleep and mental health',
                Icons.bedtime,
              ),
            ],
          ),
          ExpansionTile(
            leading: Icon(Icons.group, color: Colors.purple[700]),
            title: const Text('Support Groups'),
            children: [
              _buildResourceItem(
                'Anxiety Support Group',
                'Weekly meetings for anxiety management',
                Icons.people,
              ),
              _buildResourceItem(
                'Stress Management Group',
                'Learn and share stress management techniques',
                Icons.support_agent,
              ),
              _buildResourceItem(
                'Mindfulness Group',
                'Practice mindfulness and meditation together',
                Icons.spa,
              ),
            ],
          ),
          ExpansionTile(
            leading: Icon(Icons.school, color: Colors.purple[700]),
            title: const Text('Educational Resources'),
            children: [
              _buildResourceItem(
                'Mental Health 101',
                'Basic understanding of mental health',
                Icons.school,
              ),
              _buildResourceItem(
                'Coping Strategies',
                'Learn effective coping mechanisms',
                Icons.psychology,
              ),
              _buildResourceItem(
                'Wellness Tips',
                'Daily tips for mental well-being',
                Icons.health_and_safety,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHotlineItem(String title, String number, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.purple[700]),
      title: Text(title),
      subtitle: Text(number),
      onTap: () {
        // TODO: Implement phone call functionality
      },
    );
  }

  Widget _buildResourceItem(String title, String description, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.purple[700]),
      title: Text(title),
      subtitle: Text(description),
      onTap: () {
        // TODO: Implement resource navigation
      },
    );
  }
}
