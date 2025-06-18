class Question {
  final String questionText;
  final List<String> options;
  int? selectedIndex; // store selected option index

  Question({
    required this.questionText,
    required this.options,
    this.selectedIndex,
  });
}
