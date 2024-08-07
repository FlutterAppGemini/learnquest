import 'package:dynamic_icons/dynamic_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learnquest/common/models/course.dart';
import 'package:learnquest/common/models/lesson.dart';
import 'package:learnquest/common/routes/routes.dart';
import 'package:learnquest/feature/chat/page/chat_page.dart';
import 'package:learnquest/service/gemini_service.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late bool _saveLearn;
  @override
  void initState() {
    super.initState();
    _saveLearn = false;
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments == null || arguments is! Course) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed(Routes.error);
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final lessons = arguments.lessons;
    final course = arguments;

    Future<void> createLesson(String courseTitle, Lesson lesson) async {
      Lesson l = await GeminiService.createLesson(courseTitle, lesson);
      lessons.add(l);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeader(course.title, course.icon, course.color),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Progress".toUpperCase(),
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const Divider(
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            _buildProgressRow("Lessons",
                "${lessons.where((lesson) => lesson.progress >= 1.0).length}/${lessons.length}"),
            const SizedBox(height: 5.0),
            _buildProgressRow("Questions correct", "50/60"),
            const SizedBox(height: 5.0),
            _buildProgressRow("Questions incorrect", "10/60"),
            const SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Progress".toUpperCase(),
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      TextButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text('Generate New Lesson'),
                        onPressed: () {
                          createLesson(course.title, lessons.last);
                        },
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
            ...lessons.map((lesson) => _buildLessonRow(lesson)),
            const SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }

  ListTile _buildLessonRow(Lesson lesson) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.lesson,
          arguments: lesson,
        );
      },
      contentPadding:
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      leading: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Icon(
          lesson.progress >= 1.0
              ? FontAwesomeIcons.checkCircle
              : FontAwesomeIcons.circle,
          size: 24.0,
          color: lesson.progress >= 1.0 ? Colors.green : Colors.black54,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lesson.title,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          LinearProgressIndicator(
            value: lesson
                .progress, // Puedes ajustar este valor según el progreso real
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(
              lesson.progress >= 1.0 ? Colors.green : Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Row _buildProgressRow(String label, String value) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 20.0),
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(fontSize: 16.0, color: Colors.black),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          flex: 1,
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.right,
          ),
        ),
        const SizedBox(width: 20.0),
      ],
    );
  }

  Row _buildHeader(String name, String icon, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const SizedBox(width: 15.0),
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey.shade200,
          child: DynamicIcons.getIconFromName(icon.toLowerCase(),
              color: color, size: 40),
        ),
        const SizedBox(width: 20.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              name,
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4.0),
            const Text(
              "Created on: 01/01/2023", // Fecha de creación fija, puedes ajustarla dinámicamente
              style: TextStyle(fontSize: 14.0, color: Colors.black54),
            ),
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            setState(() {
              _saveLearn = !_saveLearn;
            });
          },
          child: Icon(
            _saveLearn
                ? FontAwesomeIcons.solidBookmark
                : FontAwesomeIcons.bookmark,
            size: 30.0,
            color: Colors.black54,
          ),
        ),
        const SizedBox(width: 15.0),
      ],
    );
  }
}
