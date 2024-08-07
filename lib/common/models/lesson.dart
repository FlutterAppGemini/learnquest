import 'package:learnquest/common/models/game.dart';

class Lesson {
  String title;
  String content;
  double progress;
  Game game;

  Lesson({
    required this.title,
    required this.content,
    required this.progress,
    required this.game,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      title: json['title'],
      content: json['content'],
      progress: 0.0,
      game: Game.fromJson(json['game']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'progress': progress,
      'game': game.toJson(),
    };
  }
}
