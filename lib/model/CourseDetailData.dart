import 'package:ace/model/LessonModule.dart';

class CourseDetailData {
  final String title;
  final String instructor;
  final String image;
  final List<LessonModule> modules;
  final String description;

  CourseDetailData({
    required this.title,
    required this.instructor,
    required this.image,
    required this.modules,
    required this.description,
  });
}
