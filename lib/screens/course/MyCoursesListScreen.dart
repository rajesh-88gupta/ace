import 'package:ace/model/Course.dart';
import 'package:ace/screens/course/dynamicCourseScreen.dart';
import 'package:flutter/material.dart';

class MyCoursesListScreen extends StatelessWidget {
   MyCoursesListScreen({super.key});
  final List<Course> courseList = [
    Course(
      title: "Clinical Skills Exam with ACE Courses",
      thumbnail: "assets/images/clinical.jpg",
      lectures: "16 Lectures",
      progress: "Complete",
      isComplete: true,
    ),
    Course(
      title: "ACE the NDECC Situational Judgement",
      thumbnail: "assets/images/judgement.jpg",
      lectures: "06 Lectures",
      progress: "Complete",
      isComplete: true,
    ),
    Course(
      title: "Advanced Dental Admission Course",
      thumbnail: "assets/images/dental.jpg",
      lectures: "12 Lectures",
      progress: "75% to complete",
      isComplete: false,
    ),
    Course(
      title: "Advanced Dental Admission Course",
      thumbnail: "assets/images/dental.jpg",
      lectures: "12 Lectures",
      progress: "75% to complete",
      isComplete: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Courses"),
        backgroundColor: const Color(0xFF683091),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: courseList.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final course = courseList[index];
          return Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Course header
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        course.thumbnail,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            course.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEDE7F6),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              course.lectures,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF683091),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Progress and button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: course.isComplete
                              ? Colors.purple
                              : Colors.orange,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          course.progress,
                          style: TextStyle(
                            color: course.isComplete
                                ? Colors.purple
                                : Colors.orange,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to course detail
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DynamicLessonScreen()),
                        );
                      },
                      child: const Text(
                        "View Details",
                        style: TextStyle(
                          color: Color(0xFF683091),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )

                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
