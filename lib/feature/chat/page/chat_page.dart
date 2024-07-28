import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final Function(bool) setLoading;
  const ChatPage({super.key, required this.setLoading});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Future<void> _simulateTask() async {
    widget.setLoading(true);

    // Simula alguna tarea que toma tiempo
    await Future.delayed(const Duration(seconds: 5));

    widget.setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _simulateTask,
          child: const Text('Simulate Loading'),
        ),
      ),
    );
  }
}
