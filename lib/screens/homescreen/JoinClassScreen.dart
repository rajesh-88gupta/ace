import 'package:flutter/material.dart';

class JoinClassScreen extends StatelessWidget {
  const JoinClassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Class'),
        backgroundColor: const Color(0xFF7B2FF2),
      ),
      body: const Center(
        child: Text(
          'Join Class Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}// TODO Implement this library.