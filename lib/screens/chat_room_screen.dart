import 'package:flutter/material.dart';
import 'dart:math';

// this is the chat room screen for the therapist and the student

class ChatRoomScreen extends StatefulWidget {
  final bool isTherapist;

  const ChatRoomScreen({
    super.key,
    this.isTherapist = false,
  });

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  final String _userId = 'User${Random().nextInt(1000)}';
  bool _isTyping = false;
  final List<String> _activeUsers = [];

  @override
  void initState() {
    super.initState();
    if (widget.isTherapist) {
      _activeUsers.addAll([
        'User${Random().nextInt(1000)}',
        'User${Random().nextInt(1000)}',
        'User${Random().nextInt(1000)}',
      ]);
    } else {
      _messages.add({
        // welcome message for student
        'text': 'Welcome to the chat! Here are some things you can ask me about:\n\n'
            '• Stress management and coping strategies\n'
            '• Anxiety and worry\n'
            '• Sleep difficulties\n'
            '• Academic pressure\n'
            '• Relationship concerns\n'
            '• Self-care techniques\n'
            '• Time management\n'
            '• Career guidance\n\n'
            'Feel free to share your thoughts or concerns, and I\'ll help you work through them.',
        'isUser': false,
        'timestamp': DateTime.now(),
      });
    }
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        // message from student is from here
        'text': _messageController.text,
        'isUser': !widget.isTherapist,
        'timestamp': DateTime.now(),
      });
      _messageController.clear();
      if (!widget.isTherapist) {
        _simulateTherapistResponse();
      }
    });
  }

  void _simulateTherapistResponse() {
    setState(() {
      _isTyping = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _messages.add({
          'text': _getTherapistResponse(_messages.last['text']),
          'isUser': false,
          'timestamp': DateTime.now(),
        });
        _isTyping = false;
      });
    });
  }

  String _getTherapistResponse(String userMessage) {
    final message = userMessage.toLowerCase();
    final responses = {
      'stress': [
        'I understand you\'re feeling stressed. Would you like to try some breathing exercises?',
        'Stress can be really challenging. Let\'s work together to find some coping strategies that work for you.',
        'It\'s completely normal to feel stressed sometimes. Would you like to talk about what\'s causing your stress?',
      ],
      'anxiety': [
        'Anxiety can be really overwhelming. Would you like to try some grounding techniques?',
        'I hear you. Anxiety can feel very isolating. Would you like to explore some ways to manage it?',
        'It\'s okay to feel anxious. Would you like to try some exercises that might help you feel more centered?',
      ],
      'sad': [
        'I hear you. It\'s important to acknowledge these feelings. Would you like to talk more about what\'s making you feel this way?',
        'Feeling sad can be really difficult. Would you like to share more about what\'s going on?',
        'It\'s okay to feel sad. Would you like to explore some ways to take care of yourself right now?',
      ],
      'depressed': [
        'Depression can be really challenging to deal with. Would you like to talk about what you\'re experiencing?',
        'I hear you. Depression can feel very isolating. Would you like to explore some coping strategies together?',
        'It\'s important to acknowledge these feelings. Would you like to talk about what might help you feel better?',
      ],
      'help': [
        'I\'m here to help. What specific support are you looking for?',
        'I\'m here to listen and support you. What would be most helpful right now?',
        'I want to help you feel better. What kind of support would be most beneficial?',
      ],
      'tired': [
        'Fatigue can be really challenging. Would you like to talk about what might be affecting your energy levels?',
        'Being tired can impact many aspects of life. Would you like to explore some ways to improve your energy?',
        'It\'s important to take care of yourself. Would you like to discuss some strategies for better rest?',
      ],
      'angry': [
        'Anger can be a difficult emotion to manage. Would you like to talk about what\'s triggering these feelings?',
        'It\'s okay to feel angry. Would you like to explore some healthy ways to express and manage this emotion?',
        'Anger can be really intense. Would you like to try some techniques to help you feel more in control?',
      ],
      'lonely': [
        'Loneliness can be really hard to deal with. Would you like to talk about what might help you feel more connected?',
        'I hear you. Feeling lonely can be really painful. Would you like to explore some ways to build connections?',
        'It\'s okay to feel lonely. Would you like to discuss some strategies for building meaningful connections?',
      ],
    };

    for (var entry in responses.entries) {
      if (message.contains(entry.key)) {
        final possibleResponses = entry.value;
        return possibleResponses[Random().nextInt(possibleResponses.length)];
      }
    }

    final defaultResponses = [
      'Thank you for sharing. How can I support you today?',
      'I\'m here to listen. Would you like to tell me more about what\'s on your mind?',
      'Thank you for opening up. What would be most helpful for you right now?',
      'I hear you. Would you like to explore this further?',
      'It\'s important to talk about these things. How can I help you feel better?',
    ];

    return defaultResponses[Random().nextInt(defaultResponses.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isTherapist ? 'Therapist Chat Room' : 'Anonymous Chat'),
        actions: widget.isTherapist
            ? [
                IconButton(
                  icon: const Icon(Icons.people),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Active Users'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: _activeUsers
                              .map((user) => ListTile(
                                    leading: const CircleAvatar(
                                      child: Icon(Icons.person),
                                    ),
                                    title: Text(user),
                                  ))
                              .toList(),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ]
            : null,
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
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return Align(
                    alignment: message['isUser']
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: message['isUser'] ? Colors.purple : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        message['text'],
                        style: TextStyle(
                          color:
                              message['isUser'] ? Colors.white : Colors.purple,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (_isTyping)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Therapist is typing...',
                  style: TextStyle(color: Colors.purple),
                ),
              ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      maxLines: 3,
                      minLines: 2,
                      decoration: InputDecoration(
                        hintText: widget.isTherapist
                            ? 'Type your response...'
                            : 'Type your message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.purple),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(Icons.send),
                    color: Colors.purple,
                    iconSize: 32,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
