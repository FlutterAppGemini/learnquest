import 'package:flutter/material.dart';
import 'package:learnquest/common/models/course.dart';
import 'package:learnquest/feature/learning/page/learning_no_content.dart';
import 'package:learnquest/feature/learning/page/learning_page_content.dart';

class LearningPage extends StatefulWidget {
  final List<Course> courses;
  const LearningPage({super.key, required this.courses});

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  @override
  Widget build(BuildContext context) {
    if (widget.courses.isNotEmpty) {
      return LearningPageContent(courses: widget.courses);
    } else {
      return const LearningNoContent();
    }
  }
}
