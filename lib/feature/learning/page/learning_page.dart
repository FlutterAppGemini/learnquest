import 'package:flutter/material.dart';
import 'package:learnquest/feature/learning/page/learning_no_content.dart';
import 'package:learnquest/feature/learning/page/learning_page_content.dart';

class Question {
  final String question;

  const Question({required this.question});

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        question: json["question"],
      );
}

class Lesson {
  final String title;
  final String icon;
  final String color;
  final List<Question> questions;

  const Lesson(
      {required this.title,
      required this.icon,
      required this.color,
      required this.questions});

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        title: json["title"],
        icon: json["icon"],
        color: json["color"],
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );
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
