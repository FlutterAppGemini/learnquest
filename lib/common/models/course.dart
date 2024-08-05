import 'package:flutter/material.dart';
import 'package:learnquest/common/models/lesson.dart';

class Course {
  String title;
  IconData icon;
  Color color;
  String description;
  List<Lesson> lessons;

  Course({
    required this.title,
    required this.icon,
    required this.color,
    required this.description,
    required this.lessons,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      title: json['title'],
      icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
      color: Color(json['color']),
      description: json['description'],
      lessons:
          (json['lessons'] as List).map((i) => Lesson.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'icon': icon.codePoint,
      'color': color.value,
      'description': description,
      'lessons': lessons.map((i) => i.toJson()).toList(),
    };
  }
}
