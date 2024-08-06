import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class GameFinished extends StatelessWidget {
  final List<Question> questions = [
    Question(
      categoryName: "General Knowledge",
      type: Type.multiple,
      difficulty: Difficulty.easy,
      question: "What is the capital of France?",
      correctAnswer: "Paris",
      incorrectAnswers: ["London", "Berlin", "Madrid"],
    ),
    Question(
      categoryName: "Science",
      type: Type.boolean,
      difficulty: Difficulty.medium,
      question: "Is the sun a star?",
      correctAnswer: "Yes",
      incorrectAnswers: ["No"],
    ),
    Question(
      categoryName: "Science",
      type: Type.boolean,
      difficulty: Difficulty.medium,
      question: "Is the sun a star?",
      correctAnswer: "Yes",
      incorrectAnswers: ["No"],
    ),
    // Agrega más preguntas según sea necesario
  ];
  final Map<int, dynamic> answers = {
    0: "Paris",
    1: "Yes",
    2: "No"
    // Agrega más respuestas según sea necesario
  };

  GameFinished({super.key});

  @override
  Widget build(BuildContext context) {
    int correct = 0;
    answers.forEach((index, value) {
      if (questions[index].correctAnswer == value) correct++;
    });

    final TextStyle titleStyle = TextStyle(
      color: Colors.grey.shade800,
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
    );

    final TextStyle trailingStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: const Text('Game Results'),
      ),
      body: Stack(
        children: <Widget>[
          // Fondo del LoginScreen adaptado
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                ClipPath(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.deepPurple[300],
                  ),
                  clipper: RoundedClipper(60),
                ),
                ClipPath(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.33,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.deepPurpleAccent,
                  ),
                  clipper: RoundedClipper(50),
                ),
                Positioned(
                    top: -110,
                    left: -110,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.30,
                      width: MediaQuery.of(context).size.height * 0.30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              (MediaQuery.of(context).size.height * 0.30) / 2),
                          color: Colors.deepPurple[300]!.withOpacity(0.3)),
                      child: Center(
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.deepPurpleAccent),
                        ),
                      ),
                    )),
                Positioned(
                    top: -100,
                    left: 100,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.36,
                      width: MediaQuery.of(context).size.height * 0.36,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              (MediaQuery.of(context).size.height * 0.36) / 2),
                          color: Colors.deepPurple[300]!.withOpacity(0.3)),
                      child: Center(
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.deepPurpleAccent),
                        ),
                      ),
                    )),
                Positioned(
                    top: -50,
                    left: 60,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.height * 0.15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              (MediaQuery.of(context).size.height * 0.15) / 2),
                          color: Colors.deepPurple[300]!.withOpacity(0.3)),
                    )),
              ],
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                _buildStatisticsCard("Total Questions", "${questions.length}",
                    titleStyle, trailingStyle),
                const SizedBox(height: 10.0),
                _buildStatisticsCard(
                    "Score",
                    "${(correct / questions.length * 100).toStringAsFixed(2)}%",
                    titleStyle,
                    trailingStyle),
                const SizedBox(height: 10.0),
                _buildStatisticsCard("Correct Answers",
                    "$correct/${questions.length}", titleStyle, trailingStyle),
                const SizedBox(height: 10.0),
                _buildStatisticsCard(
                    "Incorrect Answers",
                    "${questions.length - correct}/${questions.length}",
                    titleStyle,
                    trailingStyle),
                const SizedBox(height: 20.0),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    return _buildQuestionCard(context, index);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Card _buildStatisticsCard(String title, String value, TextStyle titleStyle,
      TextStyle trailingStyle) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(title, style: titleStyle),
        trailing: Text(value, style: trailingStyle),
      ),
    );
  }

  Card _buildQuestionCard(BuildContext context, int index) {
    Question question = questions[index];
    bool correct = question.correctAnswer == answers[index];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              question.question,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0),
            ),
            const SizedBox(height: 5.0),
            Text(
              "${answers[index]}",
              style: TextStyle(
                  color: correct ? Colors.green : Colors.red,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5.0),
            if (!correct)
              Text.rich(
                TextSpan(children: [
                  const TextSpan(text: "Answer: "),
                  TextSpan(
                      text: question.correctAnswer,
                      style: const TextStyle(fontWeight: FontWeight.w500))
                ]),
                style: const TextStyle(fontSize: 16.0),
              ),
          ],
        ),
      ),
    );
  }
}

class RoundedClipper extends CustomClipper<Path> {
  final int differenceInHeights;

  RoundedClipper(this.differenceInHeights);

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - differenceInHeights);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

enum Type { multiple, boolean }

enum Difficulty { easy, medium, hard }

class Question {
  final String categoryName;
  final Type type;
  final Difficulty difficulty;
  final String question;
  final String correctAnswer;
  final List<dynamic> incorrectAnswers;

  Question({
    required this.categoryName,
    required this.type,
    required this.difficulty,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  Question.fromMap(Map<String, dynamic> data)
      : categoryName = data["category"],
        type = data["type"] == "multiple" ? Type.multiple : Type.boolean,
        difficulty = data["difficulty"] == "easy"
            ? Difficulty.easy
            : data["difficulty"] == "medium"
                ? Difficulty.medium
                : Difficulty.hard,
        question = data["question"],
        correctAnswer = data["correct_answer"],
        incorrectAnswers = data["incorrect_answers"];

  static List<Question> fromData(List<Map<String, dynamic>> data) {
    return data.map((question) => Question.fromMap(question)).toList();
  }
}
