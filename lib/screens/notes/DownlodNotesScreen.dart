import 'package:ace/screens/notes/NoteDetailSheet.dart';
import 'package:flutter/material.dart';

class DownloadNotesScreen extends StatefulWidget {
  const DownloadNotesScreen({Key? key}) : super(key: key);

  @override
  State<DownloadNotesScreen> createState() => _DownloadNotesScreenState();
}

class _DownloadNotesScreenState extends State<DownloadNotesScreen> {
  int? selectedIndex;

  final List<Map<String, String>> notes = [
    {
      "title": "Bachelor of Dental Surgery",
      "subtitle": "Exam with ACE Courses | 10 Apr 2025 13:00",
    },
    {
      "title": "Master of Dental Surgery",
      "subtitle": "Exam with ACE Courses | 10 Apr 2025 13:40",
    },
    {
      "title": "Diploma in Cosmetic Dentistry",
      "subtitle": "Exam with ACE Courses | 10 Apr 2025 13:40",
    },
    {
      "title": "ADA CE Online",
      "subtitle": "Exam with ACE Courses | 10 Apr 2025 13:40",
    },
  ];

  void onViewTapped(int index) {
    setState(() {
      selectedIndex = index;
    });

    // Optional: Add your logic here
    debugPrint("View clicked on: ${notes[index]['title']}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Download Notes",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF683091),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notes.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final note = notes[index];

          return GestureDetector(
            onTap: () => onViewTapped(index), // Optional: also select on tap
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color:
                      selectedIndex == index
                          ? const Color(0xFF683091) // highlighted border
                          : Colors.transparent,
                  width: 2,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    spreadRadius: 1,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          note['title']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          note['subtitle']!,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // This is what happens when "View" is tapped
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        builder: (context) => const NoteDetailSheet(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF683091),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "View",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
