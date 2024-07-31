import 'package:flutter/material.dart';
import 'package:learnquest/feature/learning/page/learning_no_content.dart';
import 'package:learnquest/feature/learning/page/learning_page_content.dart';

class Lesson {
  final String title;
  final String img;
  final String color;

  const Lesson({required this.title, required this.img, required this.color});
}

class LearningPage extends StatefulWidget {
  final List<Lesson> lessons;
  const LearningPage({super.key, required this.lessons});

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.lessons.isNotEmpty) {
      return LearningPageContent(lessons: widget.lessons);
    } else {
      return const LearningNoContent();
    }
  }
}
