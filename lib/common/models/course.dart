import 'package:flutter/material.dart';
import 'package:learnquest/common/models/lesson.dart';

class Course {
  String title;
  String icon;
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
      icon: json['icon'],
      color: Color(int.parse(json['color'], radix: 16) + 0xFF000000),
      description: json['description'],
      lessons:
          (json['lessons'] as List).map((i) => Lesson.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'icon': icon,
      'color': color.value,
      'description': description,
      'lessons': lessons.map((i) => i.toJson()).toList(),
    };
  }
}
