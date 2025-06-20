import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  final List<Map<String, String>> reminders = [
    {
      'day': 'Mon',
      'date': '24',
      'title': 'Salesmate Demo',
      'time': '10 Apr 2025 13:40'
    },
    {
      'day': 'Fri',
      'date': '14',
      'title': 'TE-450 TEST',
      'time': '18 Apr 2025 15:50'
    },
    {
      'day': 'Mon',
      'date': '10',
      'title': '450 TEST',
      'time': '18 Apr 2025 10:30'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        backgroundColor: const Color(0xFF683091),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              focusedDay: focusedDay,
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.purple,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.deepPurple,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              selectedDayPredicate: (day) => isSameDay(day, selectedDay),
              onDaySelected: (selected, focused) {
                setState(() {
                  selectedDay = selected;
                  focusedDay = focused;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "Reminders",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...reminders.map((item) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xFF683091).withOpacity(0.1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item['day']!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Color(0xFF683091)),
                          ),
                          Text(
                            item['date']!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xFF683091)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['time']!,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const NoteDetailDialog(),
                        );
                      },
                      child: const Text(
                        "Details",
                        style: TextStyle(
                          color: Color(0xFF683091),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  ],
                ),
              );
            }).toList()
          ],
        ),
      ),
    );
  }
}
class NoteDetailDialog extends StatelessWidget {
  const NoteDetailDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close icon
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close, size: 22),
              ),
            ),
            const SizedBox(height: 8),

            // Title and subtitle
            const Text(
              "Bachelor of Dental Surgery",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 6),
            const Text(
              "Exam with ACE Courses | 10 Apr 2025 13:40",
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 16),

            // Scrollable description
            const SingleChildScrollView(
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                    "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                    "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\n"
                    "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. "
                    "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                style: TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 20),

            // Downloads button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Or trigger download here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF683091),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Downloads",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
