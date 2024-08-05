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
          "  \"icon\": \"icono-dinamico (por ejemplo de dynamic_icons:widgets solo necesitaría 'widgets', si el título es geografía, usa un icon de geography, si te hablan de flutter, usa el icono 'flutter_dash' pq encajaría mejor con ello, no uses únicamente el widget 'widgets' usa tu imaginación para variar en el icono elegido)\",\n"
          "  \"color\": \"000000(no necesariamente tiene que ser este color, puede ser cualquier otro)\",\n"
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

  static Future<bool> isInappropiate(String prompt) async {
    final content = [
      Content.text(
          "Por favor, analiza el siguiente texto y devuelve un objeto JSON con los siguientes campos:\n"
          "{\n"
          "  \"reason\": \"string\",\n"
          "  \"value\": \"boolean\"\n"
          "}\n"
          "El texto a analizar es: '$prompt'.\n"
          "El campo 'reason' debe contener una descripción del motivo si se encuentra contenido inapropiado.\n"
          "El campo 'value' debe ser true si el texto contiene contenido inapropiado, y false en caso contrario.\n"
          "La respuesta debe ser solo el JSON, sin texto adicional.")
    ];

    final response = (await GeminiService.model.generateContent(content));
    print("El valor booleano es: ${response.text}");
    final map = jsonDecode(response.text ?? '') as Map<String, dynamic>;
    return map["value"];
  }
}
