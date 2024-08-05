import 'package:dynamic_icons/dynamic_icons.dart';
import 'package:flutter/material.dart';
import 'package:learnquest/feature/chat/page/chat_page.dart';
import 'package:learnquest/feature/learning/page/learning_page.dart';

class LearningPageContent extends StatefulWidget {
  final List<Lesson> lessons;
  const LearningPageContent({super.key, required this.lessons});

  @override
  State<LearningPageContent> createState() => _LearningPageContentState();
}

class _LearningPageContentState extends State<LearningPageContent> {
  Widget _buildWikiCategory(String icon, String label, Color color) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(26.0),
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Opacity(
              opacity: 0.1,
              child: DynamicIcons.getIconFromName(
                icon,
                color: Colors.black,
                size: 40.0,
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 16.0),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Número de elementos por fila
          crossAxisSpacing: 10.0, // Espaciado entre las columnas
          mainAxisSpacing: 10.0, // Espaciado entre las filas
          childAspectRatio: 1, // Relación de aspecto de los elementos
        ),
        itemCount: widget.lessons.length,
        itemBuilder: (context, index) {
          final lesson = widget.lessons[index];
          return Card(
            child: _buildWikiCategory(lesson.icon, lesson.title,
                Color(int.parse(lesson.color, radix: 16) + 0xFF000000)),
          );
        },
      ),
    );
  }
}
