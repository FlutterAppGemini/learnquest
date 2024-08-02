import 'dart:io';
import 'package:flutter/material.dart';
import 'package:learnquest/common/routes/routes.dart';

class LessonDetail extends StatefulWidget {
  const LessonDetail({super.key});

  @override
  State<LessonDetail> createState() => _LessonDetailState();
}

class _LessonDetailState extends State<LessonDetail>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  double _progress = 0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateProgress);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  void _updateProgress() {
    final maxScrollExtent = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    setState(() {
      _progress = (currentScroll / maxScrollExtent).clamp(0, 1);
      if (_progress == 1) {
        _animationController.forward();
      } else {
        _animationController.reset();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateProgress);
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments == null || arguments is! String) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed(Routes.error);
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final lesson = arguments;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.play_circle_filled),
            label: const Text("Start Game"),
            onPressed: _progress < 1 ? null : () {},
            style: TextButton.styleFrom(
              foregroundColor: _progress < 1 ? Colors.grey : Colors.blue,
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: ScaleTransition(
            scale: _animationController.drive(Tween(begin: 1.0, end: 1.5)
                .chain(CurveTween(curve: Curves.elasticOut))),
            child: LinearProgressIndicator(
              value: _progress,
              backgroundColor: Colors.grey[200],
              color: Colors.blue,
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.all(20.0),
              children: <Widget>[
                Text(
                  lesson.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 24.0, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16.0),
                const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent lacinia, odio ut placerat finibus, ipsum risus consectetur ligula, non mattis mi neque ac mi."),
                const SizedBox(height: 20.0),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.memory),
                    SizedBox(width: 5.0),
                    Text("65%"),
                  ],
                ),
                const SizedBox(height: 20.0),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent lacinia, odio ut placerat finibus, ipsum risus consectetur ligula, non mattis mi neque ac mi. Vivamus quis tellus sed erat eleifend pharetra ac non diam. Integer vitae ipsum congue, vestibulum eros quis, interdum tellus. Nunc vel dictum elit. Curabitur suscipit scelerisque.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent lacinia, odio ut placerat finibus, ipsum risus consectetur ligula, non mattis mi neque ac mi. Vivamus quis tellus sed erat eleifend pharetra ac non diam. Integer vitae ipsum congue, vestibulum eros quis, interdum tellus. Nunc vel dictum elit. Curabitur suscipit scelerisque.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent lacinia, odio ut placerat finibus, ipsum risus consectetur ligula, non mattis mi neque ac mi. Vivamus quis tellus sed erat eleifend pharetra ac non diam. Integer vitae ipsum congue, vestibulum eros quis, interdum tellus. Nunc vel dictum elit. Curabitur suscipit scelerisque.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent lacinia, odio ut placerat finibus, ipsum risus consectetur ligula, non mattis mi neque ac mi. Vivamus quis tellus sed erat eleifend pharetra ac non diam. Integer vitae ipsum congue, vestibulum eros quis, interdum tellus. Nunc vel dictum elit. Curabitur suscipit scelerisque.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent lacinia, odio ut placerat finibus, ipsum risus consectetur ligula, non mattis mi neque ac mi. Vivamus quis tellus sed erat eleifend pharetra ac non diam. Integer vitae ipsum congue, vestibulum eros quis, interdum tellus. Nunc vel dictum elit. Curabitur suscipit scelerisque.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent lacinia, odio ut placerat finibus, ipsum risus consectetur ligula, non mattis mi neque ac mi. Vivamus quis tellus sed erat eleifend pharetra ac non diam. Integer vitae ipsum congue, vestibulum eros quis, interdum tellus. Nunc vel dictum elit. Curabitur suscipit scelerisque.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent lacinia, odio ut placerat finibus, ipsum risus consectetur ligula, non mattis mi neque ac mi. Vivamus quis tellus sed erat eleifend pharetra ac non diam. Integer vitae ipsum congue, vestibulum eros quis, interdum tellus. Nunc vel dictum elit. Curabitur suscipit scelerisque."),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
