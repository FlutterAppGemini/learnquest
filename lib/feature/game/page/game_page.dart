import 'package:flutter/material.dart';
import 'package:learnquest/common/models/game.dart';
import 'package:learnquest/common/routes/routes.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    // final arguments = ModalRoute.of(context)!.settings.arguments;

    // if (arguments == null || arguments is! Game) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     Navigator.of(context).pushReplacementNamed(Routes.home);
    //   });
    //   return const Scaffold(
    //     body: Center(child: CircularProgressIndicator()),
    //   );
    // }

    // final game = arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text("game.type"),
      ),
      body: const Row(),
    );
  }
}
