import 'package:flutter/material.dart';

class LearningNoContent extends StatefulWidget {
  const LearningNoContent({super.key});

  @override
  State<LearningNoContent> createState() => _LearningNoContentState();
}

class _LearningNoContentState extends State<LearningNoContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Aún no ha generado ninguna lección'),
            SizedBox(height: 20),
            Image(
              image: NetworkImage('https://i.ibb.co/Kywy7pR/no-content.png'),
              height: 200.0,
              width: 200.0,
            ),
            // Añadir un espacio entre la imagen y el texto
          ],
        ),
      ),
    );
  }
}
