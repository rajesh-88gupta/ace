class Course {
  final String title;
  final String thumbnail;
  final String lectures;
  final String progress;
  final bool isComplete;

  Course({
    required this.title,
    required this.thumbnail,
    required this.lectures,
    required this.progress,
    this.isComplete = false,
  });
}
