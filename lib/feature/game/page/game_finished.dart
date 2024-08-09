import 'package:flutter/material.dart';
import 'package:learnquest/feature/game/page/game_page.dart';

class GameFinished extends StatefulWidget {
  @override
  _GameFinishedState createState() => _GameFinishedState();
}

class _GameFinishedState extends State<GameFinished> {
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
  ];

  final Map<int, dynamic> answers = {0: "Paris", 1: "Yes", 2: "No"};

  @override
  Widget build(BuildContext context) {
    int correct = 0;
    answers.forEach((index, value) {
      if (questions[index].correctAnswer == value) correct++;
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            decoration: const BoxDecoration(
              color: Colors.deepPurpleAccent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(context, Icons.replay, "Play Again", () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const GamePage()));
                  }),
                  _buildActionButton(
                      context, Icons.arrow_back, "Back to Lesson", () {
                    Navigator.of(context).pop();
                  }),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 10,
                    ),
                  ],
                ),
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatisticsColumn(
                            "Completion", "100%", Colors.purple),
                        _buildStatisticsColumn("Total Question",
                            "${questions.length}", Colors.purple),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatisticsColumn(
                            "Correct", "$correct", Colors.green),
                        _buildStatisticsColumn("Wrong",
                            "${questions.length - correct}", Colors.red),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildAnswersList(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnswersList() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(questions[index].question),
              subtitle: Text(
                'Correct Answer: ${questions[index].correctAnswer}',
                style: const TextStyle(color: Colors.green),
              ),
              trailing: Icon(
                answers[index] == questions[index].correctAnswer
                    ? Icons.check_circle
                    : Icons.cancel,
                color: answers[index] == questions[index].correctAnswer
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }

  Column _buildStatisticsColumn(String title, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 5,
              backgroundColor: color,
            ),
            const SizedBox(width: 5),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String label,
      VoidCallback onPressed) {
    return Column(
      children: [
        FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: onPressed,
          child: Icon(icon, color: Colors.deepPurpleAccent),
        ),
        const SizedBox(height: 8.0),
        Text(label, style: const TextStyle(color: Colors.black)),
      ],
    );
  }
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
