import 'package:flutter/cupertino.dart';

class NoteItem {
  final String title;
  final String subtitle;
  final VoidCallback onView;

  NoteItem({
    required this.title,
    required this.subtitle,
    required this.onView,
  });
}
