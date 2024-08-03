import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:learnquest/feature/learning/page/learning_page.dart';

class GeminiService {
  static late GenerativeModel model;

  static Future<void> load() async {
    final String apiKey = dotenv.env['GEMINI_API'].toString();
    GeminiService.model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
        generationConfig:
            GenerationConfig(responseMimeType: "application/json"));
  }

  static Future<Lesson> createLesson(String prompt) async {
    final content = [
      Content.text(
          "Por favor, genera un objeto JSON que siga este formato exacto para el tema '$prompt':\n"
          "class Question {\n"
          "  final String question;\n"
          "  const Question({required this.question});\n"
          "}\n\n"
          "class Lesson {\n"
          "  final String title;\n"
          "  final String icon;  // Asegúrate de incluir un valor de string de la documentación de Icon class de la página 'https://api.flutter.dev/flutter/material/Icons-class.html' DynamicIcons.getIconFromName\n"
          "  final String color;\n //Asegúrate que el valor de string de color no tenga numeral '#'"
          "  final List<Question> questions;\n"
          "  const Lesson({required this.title, required this.icon, required this.color, required this.questions});\n"
          "}\n\n"
          "La respuesta debe ser solo un JSON válido, incluyendo un campo 'icon' con un valor dinámico. Ejemplo de formato JSON:\n"
          "{\n"
          "  \"title\": \"Título de ejemplo\",\n"
          "  \"icon\": \"icono-dinamico\",\n"
          "  \"color\": \"FF9800(no necesariamente tiene que ser este color, puede ser cualquier otro)\",\n"
          "  \"questions\": [\n"
          "    {\"question\": \"Pregunta 1\"},\n"
          "    {\"question\": \"Pregunta 2\"}\n"
          "  ]\n"
          "}\n"
          "el atributo questions debe tener una lista de entre 20 a 30 question puedes elegir de forma random"
          "No incluyas ningún texto adicional fuera del JSON.")
    ];

    final response = (await GeminiService.model.generateContent(content));

    print(response.text);

    final map = jsonDecode(response.text ?? '') as Map<String, dynamic>;
    final lesson = Lesson.fromJson(map);
    return lesson;
  }
}
