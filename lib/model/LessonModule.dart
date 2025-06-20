import 'package:ace/model/LessonChapter.dart';

class LessonModule {
  final String name;
  final String totalDuration;
  final String lectureCount;
  final List<LessonChapter> chapters;

  LessonModule({
    required this.name,
    required this.totalDuration,
    required this.lectureCount,
    required this.chapters,
  });
}
