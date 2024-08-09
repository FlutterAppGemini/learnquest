import 'dart:convert';

import 'package:dynamic_icons/dynamic_icons.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:learnquest/common/models/course.dart';

import '../common/models/lesson.dart';

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

  static Future<Course> createCourse(String prompt) async {
    bool hasError;
    Course? course;
    String iconList = jsonEncode(DynamicIcons.iconList.keys.toList());
    do {
      try {
        final content = [
          Content.text(
            "Genera una colección json con todos los corchetes y llaves bien puestas para evitar cualquier FormatException relativo al tema de $prompt (genera un curso con relatividad a ese tema, no me generes un tema de matematica por defecto) con esta estructura esperada:\n{\n    \"title\": \"titulo\",\n    \"icon\": \"El valor a retornar debe ser uno de los elementos de la lista: $iconList\",\n    \"color\": \"es un String que representa un color pero en sistema hexadecimal(no incluyas el numeral)\",\n    \"description\": \"descripcion breve de la materia o lo q se vera\",\n    \"lessons\": [\n        {\n            \"title\": \"titulo de la leccion\",\n            \"content\": \"contenido de toda la leccion, informacion a modo de texto debe ser extenso si es posible, debe estar detallado para q cualquier usuario de cualquier edad lo entienda, debe estar relacionado con las preguntas q se hace, con respectivos ejemplos\",\n            \"progress\": 0,\n            \"game\": {\n                \"type\": \"tipo de juego 'selection' o para 'write' (solo usa esos 2 valores pq tengo un enum asi enum Type { write, selection })\",\n                \"data\": [\n                    {\n                        \"question\": \"pregunta 1\",\n                        \"response\": [\n                            \"respuesta 1\",\n                            \"respuesta 2\",\n                            \"respuesta 3\",\"respuesta 4\",\"respuesta 5\"\n                        ],\n                        \"solution\": \"respuesta 1\"\n                    },\n                    {\n                        \"question\": \"pregunta 2\",\n                        \"response\": [\n                            \"respuesta 1\",\n                            \"respuesta 2\",\n                            \"respuesta 3\"\n                        ],\n                        \"solution\": \"respuesta 3\"\n                    }\n                ]\n            }\n        }\n    ]\n}\n\n1. Al solicitar una lección inicial sobre un tema, la respuesta debe seguir la estructura anterior.\n2. El \"type\" de \"game\" debe ser determinado por la IA (cuestionario o escribir).\n3. La ia decide la cantidad de preguntas(entre 5 y 8) y la cantidad de respuestas para cada pregunta(entre 4 y 7).\n\nEjemplo de solicitud para una lección de matemáticas:\n\"Quiero aprender sobre matemáticas\"\n\nEjemplo de solicitud para validar respuestas en un juego de escribir:\n{\n    \"type\": \"write\",\n    \"data\": [\n        {\"question\": \"¿Cuál es la capital de Francia?\", \"response\": [\"París\"], \"user_answer\": \"Paris\"}\n    ]\n}",
          )
        ];

        final response = (await GeminiService.model.generateContent(content));

        print(response.text);

        final map = jsonDecode(response.text ?? '') as Map<String, dynamic>;
        course = Course.fromJson(map);
        hasError = false;
      } on FormatException {
        hasError = true;
      }
    } while (hasError);

    print(course?.lessons.last.toJson());
    return course!;
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
    final map = jsonDecode(response.text ?? '') as Map<String, dynamic>;

    print("El valor booleano es: ${response.text}");
    return map["value"];
  }

  static Future<Lesson> createLesson(String courseTitle, Lesson lesson) async {
    bool hasError;
    Lesson? newLesson;

    try {
      final content = [
        Content.text(
            "Necesito que me devuelvas una colección json con los corchetes bien puestos para evitar un FormatException con una estructura similar a esta de acuerdo el tema del curso es $courseTitle, esta es la ultima lección que ha tenido el curso, necesito que generes un lesson con esta estructura tal que sea una continuación del curso\n ${jsonEncode(lesson.toJson())}")
      ];
      final response = (await GeminiService.model.generateContent(content));
      final map = jsonDecode(response.text ?? '') as Map<String, dynamic>;

      print(response.text);
      newLesson = Lesson.fromJson(map);
      hasError = false;
    } on FormatException {
      hasError = true;
    }

    return newLesson!;
  }
}
