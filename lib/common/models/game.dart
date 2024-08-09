import 'package:learnquest/common/models/question.dart';

enum Type { write, selection }

class Game {
  Type type;
  List<Question> data;

  Game({
    required this.type,
    required this.data,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      type: _typeFromString(json['type']),
      data: (json['data'] as List).map((i) => Question.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.toString().split('.').last,
      'data': data.map((i) => i.toJson()).toList(),
    };
  }

  static Type _typeFromString(String type) {
    switch (type) {
      case 'write':
        return Type.write;
      case 'selection':
        return Type.selection;
      default:
        throw Exception('Unknown type: $type');
    }
  }
}
