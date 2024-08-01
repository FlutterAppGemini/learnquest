import 'package:flutter/material.dart';
import 'package:learnquest/feature/learning/page/learning_page.dart';

class LearningPageContent extends StatefulWidget {
  final List<Lesson> lessons;
  const LearningPageContent({super.key, required this.lessons});

  @override
  State<LearningPageContent> createState() => _LearningPageContentState();
}

class _LearningPageContentState extends State<LearningPageContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Número de elementos por fila
          crossAxisSpacing: 10.0, // Espaciado entre las columnas
          mainAxisSpacing: 10.0, // Espaciado entre las filas
          childAspectRatio: 1, // Relación de aspecto de los elementos
        ),
        itemCount: widget.lessons.length,
        itemBuilder: (context, index) {
          final lesson = widget.lessons[index];
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80.0, // Tamaño del círculo
                  height: 80.0,
                  decoration: BoxDecoration(
                    color:
                        Color(int.parse(lesson.color, radix: 16) + 0xFF000000),
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.yellow, width: 2.0), // Borde del círculo
                    image: DecorationImage(
                      image: NetworkImage(lesson.img), // Imagen desde URL
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  lesson.title,
                  textAlign: TextAlign.center, // Centra el texto
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
