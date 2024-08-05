import 'package:learnquest/common/models/question.dart';

class Game {
  String type;
  List<Question> data;

  Game({
    required this.type,
    required this.data,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      type: json['type'],
      data: (json['data'] as List).map((i) => Question.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'data': data.map((i) => i.toJson()).toList(),
    };
  }
}
