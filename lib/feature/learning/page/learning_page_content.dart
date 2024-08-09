import 'package:dynamic_icons/dynamic_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learnquest/common/models/course.dart';
import 'package:learnquest/common/routes/routes.dart';

class LearningPageContent extends StatefulWidget {
  final List<Course> courses;
  const LearningPageContent({super.key, required this.courses});

  @override
  State<LearningPageContent> createState() => _LearningPageContentState();
}

class _LearningPageContentState extends State<LearningPageContent> {
  Widget _buildCourseCard(
      String icon, String label, Color color, double progress) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.1),
            child: DynamicIcons.getIconFromName(
              icon.toLowerCase(),
              color: color,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "10 hours, 19 lessons",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[200],
                  color: color,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Icon(Icons.play_arrow, color: color),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GridView.builder(
            padding: const EdgeInsets.only(top: 200),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 3.5,
            ),
            itemCount: widget.courses.length,
            itemBuilder: (context, index) {
              final course = widget.courses[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.detail,
                    arguments: course,
                  );
                },
                child: _buildCourseCard(
                    course.icon, course.title, course.color, 0.25),
              );
            },
          ),
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF7B1FA2),
                      Color(0xFFD81B60),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      "UI/UX Courses",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatisticCard(
                            Icons.library_books, "Courses", "120"),
                        _buildStatisticCard(Icons.access_time, "Hours", "300h"),
                        _buildStatisticCard(
                            Icons.show_chart, "Progress Total", "75%"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticCard(IconData icon, String label, String count) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.2),
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        Text(
          count,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class Learn {
  String name;
  IconData icon;
  Color color;
  Learn(
    this.name,
    this.icon,
    this.color,
  );
}

final List<Learn> learn = [
  Learn(
    'UX Designer\nfrom Scratch.',
    Icons.design_services,
    Colors.purple,
  ),
  Learn(
    'Design Thinking\nThe Beginner',
    Icons.lightbulb,
    Colors.blue,
  ),
  Learn(
    'Math',
    Icons.calculate,
    Colors.blue[400]!,
  ),
  Learn(
    'Geography',
    Icons.public,
    Colors.orange[400]!,
  ),
  Learn(
    'Programming',
    Icons.computer,
    Colors.indigo[400]!,
  ),
  Learn(
    'Web',
    Icons.web,
    Colors.green[400]!,
  ),
  Learn(
    'Cook',
    Icons.kitchen,
    Colors.orange[400]!,
  ),
  Learn(
    'Cloud',
    Icons.cloud,
    Colors.lightBlue[600]!,
  ),
  Learn(
    'SQL',
    FontAwesomeIcons.database,
    Colors.lightGreen[600]!,
  ),
];
