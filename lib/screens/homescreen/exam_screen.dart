import 'package:ace/model/Question.dart';
import 'package:ace/screens/HomeScreen.dart';
import 'package:flutter/material.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  int currentQuestionIndex = 0;
  final List<Question> sampleQuestions = [
    Question(
      questionText: 'What is Flutter?',
      options: ['Framework', 'Library', 'Plugin', 'App'],
    ),
    Question(
      questionText: 'Which language is used by Flutter?',
      options: ['Java', 'Kotlin', 'Dart', 'Swift'],
    ),
    Question(
      questionText: 'Who developed Flutter?',
      options: ['Apple', 'Google', 'Facebook', 'Microsoft'],
    ),
  ];

  // final List<Question> questions = sampleQuestions;

  void _selectOption(int index) {
    setState(() {
      sampleQuestions[currentQuestionIndex].selectedIndex = index;
    });
  }

  void _goToNext() {
    if (currentQuestionIndex < sampleQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  void _goToPrevious() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  void _submitExam() {
    // You can send questions list to server or review answers
    for (var q in sampleQuestions) {
      print('Q: ${q.questionText}, Answer: ${q.selectedIndex}');
    }

    // Show a simple confirmation
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Exam Submitted"),
            content: const Text("Your answers have been saved successfully."),
            actions: [
              TextButton(
                onPressed:
                    () => {
                      Navigator.of(context).pop(),
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      ),
                    },
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = sampleQuestions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(title: const Text('Exam Module')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Question ${currentQuestionIndex + 1}/${sampleQuestions.length}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(question.questionText, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            ...List.generate(
              question.options.length,
              (index) => RadioListTile<int>(
                title: Text(question.options[index]),
                value: index,
                groupValue: question.selectedIndex,
                onChanged: (value) {
                  _selectOption(value!);
                },
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _goToPrevious,
                  child: const Text('Previous'),
                ),
                ElevatedButton(onPressed: _goToNext, child: const Text('Next')),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitExam,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
