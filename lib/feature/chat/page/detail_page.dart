import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learnquest/common/routes/routes.dart';
import 'package:learnquest/feature/chat/page/chat_page.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late bool _saveLearn;
  late List<Lesson> lessons;
  @override
  void initState() {
    super.initState();
    _saveLearn = false;
    lessons = [
      Lesson("Lesson 4", "Advanced Algebra", 0.6),
      Lesson("Lesson 3", "Geometry Basics", 1.0),
      Lesson("Lesson 2", "Basic Algebra", 0.9),
      Lesson("Lesson 1", "Introduction to Math", 1.0),
    ];
  }

  void _addNewLesson() {
    setState(() {
      int newLessonNumber = lessons.length + 1;
      lessons.insert(0, Lesson("Lesson $newLessonNumber", "New Lesson", 0.0));
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments == null || arguments is! Learn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed(Routes.error);
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final learn = arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: HeaderWidget(
        header: _buildHeader(learn.name, learn.icon, learn.color),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 10.0),
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
              _buildProgressRow("Lessons",
                  "${lessons.where((lesson) => lesson.progress >= 1.0).length}/${lessons.length}"),
              _buildProgressRow("Questions correct", "50/60"),
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
                          "Lessons".toUpperCase(),
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        TextButton.icon(
                          onPressed: _addNewLesson,
                          icon: const Icon(Icons.add),
                          label: const Text('Generate New Lesson'),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
              ...lessons.map((lesson) => _buildLessonRow(
                  lesson.name, lesson.subtitle, lesson.progress)),
              const SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }

  ListTile _buildLessonRow(
      String lessonName, String lessonSubtitle, double progress) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.lesson,
          arguments: lessonName,
        );
      },
      contentPadding:
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      leading: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Icon(
          progress >= 1.0
              ? FontAwesomeIcons.checkCircle
              : FontAwesomeIcons.circle,
          size: 24.0,
          color: progress >= 1.0 ? Colors.green : Colors.black54,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lessonName,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4.0),
          Text(
            lessonSubtitle,
            style: const TextStyle(color: Colors.black54, fontSize: 14.0),
          ),
          const SizedBox(height: 8.0),
          LinearProgressIndicator(
            value: progress, // Puedes ajustar este valor según el progreso real
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(
              progress >= 1.0 ? Colors.green : Colors.blue,
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

  Row _buildHeader(String name, IconData icon, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const SizedBox(width: 15.0),
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey.shade200,
          child: Icon(
            icon,
            size: 40,
            color: color,
          ),
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

class Lesson {
  final String name;
  final String subtitle;
  final double progress;

  Lesson(this.name, this.subtitle, this.progress);
}

class HeaderWidget extends StatelessWidget {
  final Widget? body;
  final Widget? header;
  final Color headerColor;
  final Color backColor;

  const HeaderWidget(
      {super.key,
      this.body,
      this.header,
      this.headerColor = Colors.white,
      this.backColor = Colors.deepPurple});

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Stack _buildBody() {
    return Stack(
      children: <Widget>[
        Positioned(
          right: 0,
          top: 0,
          width: 10,
          height: 200,
          child: DecoratedBox(
            decoration: BoxDecoration(
                color: backColor,
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(20.0))),
          ),
        ),
        Positioned(
          right: 0,
          top: 100,
          width: 50,
          bottom: 0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: backColor,
            ),
          ),
        ),
        Column(
          children: <Widget>[
            if (header != null)
              Container(
                  margin: const EdgeInsets.only(right: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(20.0)),
                    color: headerColor,
                  ),
                  child: header),
            if (body != null)
              Expanded(
                child: Material(
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(30.0))),
                    elevation: 0,
                    color: backColor,
                    child: body),
              ),
          ],
        ),
      ],
    );
  }
}
