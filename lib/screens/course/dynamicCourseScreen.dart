import 'package:ace/model/CourseDetailData.dart';
import 'package:ace/model/LessonChapter.dart';
import 'package:ace/model/LessonModule.dart';
import 'package:flutter/material.dart';

class DynamicLessonScreen extends StatefulWidget {
  const DynamicLessonScreen({super.key});

  @override
  State<DynamicLessonScreen> createState() => _DynamicLessonScreenState();
}

class _DynamicLessonScreenState extends State<DynamicLessonScreen> {
  String selectedTab = 'Course Content';
  int? expandedIndex;
  final CourseDetailData myCourseDetail = CourseDetailData(
    title: "Direct Composite Veneers",
    instructor: "Prof. M. Kleicio Alves",
    image: "assets/images/veneer_banner.jpg",
    description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
    modules: [
      LessonModule(
        name: "Module 1",
        totalDuration: "3h 35m",
        lectureCount: "21 lectures",
        chapters: [
          LessonChapter(title: "Introduction", duration: "35m"),
          LessonChapter(title: "Chapter 1.1", duration: "45m"),
        ],
      ),
      LessonModule(
        name: "Module 2",
        totalDuration: "2h 15m",
        lectureCount: "10 lectures",
        chapters: [
          LessonChapter(title: "Chapter 2.1", duration: "1h"),
          LessonChapter(title: "Chapter 2.2", duration: "1h 15m"),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final course = myCourseDetail;

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Courses"),
        backgroundColor: const Color(0xFF683091),
      ),
      body: Column(
        children: [
          Image.asset(
            course.image,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(course.title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.person, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text("Created by ${course.instructor}",
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),

          // Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                _buildTab("Course Content"),
                const SizedBox(width: 10),
                _buildTab("Description"),
              ],
            ),
          ),
          const SizedBox(height: 10),

          Expanded(
            child: selectedTab == "Course Content"
                ? _buildModuleList(course.modules)
                : _buildDescription(course.description),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String tabName) {
    final bool isSelected = selectedTab == tabName;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = tabName;
            expandedIndex = null;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF683091) : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              tabName,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModuleList(List<LessonModule> modules) {
    return ListView.builder(
      itemCount: modules.length,
      itemBuilder: (context, index) {
        final module = modules[index];
        final isExpanded = expandedIndex == index;

        return Column(
          children: [
            ListTile(
              title: Text(module.name),
              subtitle: Text("${module.totalDuration} • ${module.lectureCount}"),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                setState(() {
                  expandedIndex = isExpanded ? null : index;
                });
              },
            ),
            if (isExpanded)
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Column(
                  children: module.chapters
                      .map((c) => ListTile(
                    leading: const Icon(Icons.play_circle_outline,
                        color: Color(0xFF683091)),
                    title: Text(c.title),
                    subtitle: Text(c.duration),
                  ))
                      .toList(),
                ),
              )
          ],
        );
      },
    );
  }

  Widget _buildDescription(String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Overview",
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text("FAQ", style: TextStyle(color: Colors.grey)),
                Text("Reviews", style: TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              desc,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
