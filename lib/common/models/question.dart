class Question {
  String question;
  List<String> response;
  String solution;

  Question({
    required this.question,
    required this.response,
    required this.solution,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
      response: List<String>.from(json['response']),
      solution: json['solution'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'response': response,
      'solution': solution,
    };
  }
}
