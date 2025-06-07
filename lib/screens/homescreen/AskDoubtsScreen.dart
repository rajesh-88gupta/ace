import 'package:flutter/material.dart';

class AskDoubtsScreen extends StatelessWidget {
  const AskDoubtsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ask Doubts'),
        backgroundColor: const Color(0xFF7B2FF2),
      ),
      body: const Center(
        child: Text(
          'Ask Doubts Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}// TODO Implement this library.