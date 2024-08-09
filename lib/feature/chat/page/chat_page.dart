import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:learnquest/common/models/course.dart';
import 'package:learnquest/common/routes/routes.dart';
import 'package:learnquest/service/gemini_service.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ChatPage extends StatefulWidget {
  final List<Course> courses;
  final Function(bool) setLoading;
  const ChatPage({super.key, required this.setLoading, required this.courses});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Future<void> _simulateTask() async {
    widget.setLoading(true);

    await Future.delayed(const Duration(seconds: 5));

    widget.setLoading(false);
  }

  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    GeminiService.load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _createLesson(String value) async {
    try {
      bool valor = await GeminiService.isInappropiate(value);
      if (!valor) {
        await GeminiService.load();
        Course course = await GeminiService.createCourse(value);
        widget.courses.add(course);
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          text: 'El tema que deseas aprender es inapropiado',
        );
      }
    } on GenerativeAIException {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: 'Los temas inapropiados no están permitidos',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    createTile(Learn learn) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.detail,
                arguments: learn,
              );
            },
            child: Container(
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
                    backgroundColor: learn.color.withOpacity(0.1),
                    child: Icon(learn.icon, color: learn.color, size: 30),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          learn.name,
                          style: TextStyle(
                            color: learn.color,
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
                          value: 0.25,
                          backgroundColor: Colors.grey[200],
                          color: learn.color,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(Icons.play_arrow, color: learn.color),
                ],
              ),
            ),
          ),
        );

    final lessonsList = ListView.builder(
      itemCount: learn.length,
      itemBuilder: (context, index) {
        return createTile(learn[index]);
      },
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF5F7FA),
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF7B1FA2),
                      Color(0xFFD81B60),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      const Text(
                        "Welcome to New",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "Educourse",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        controller: _controller,
                        textInputAction: TextInputAction.send,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 20.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Enter your Keyword",
                          prefixIcon: IconButton(
                            icon: const Icon(Icons.mic,
                                color: Color.fromARGB(255, 1, 82, 173)),
                            onPressed: () {
                              // Lógica para escuchar voz
                            },
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.send,
                                color: Color.fromARGB(255, 1, 82, 173)),
                            onPressed: () {
                              _createLesson(_controller.text);
                              _controller.clear();
                            },
                          ),
                        ),
                        onSubmitted: (value) {
                          _createLesson(value);
                          _controller.clear();
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Text(
                      "Course For You",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: lessonsList,
                ),
              ),
            ],
          ),
        ],
      ),
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
