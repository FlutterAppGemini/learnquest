import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learnquest/common/models/lesson.dart';
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
  double _secondaryProgress = 0;
  late AnimationController _animationController;
  final GlobalKey _contentKey = GlobalKey();

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
    final newProgress = (currentScroll / maxScrollExtent).clamp(0, 1);

    setState(() {
      _progress = newProgress > _progress ? newProgress as double : _progress;
      _secondaryProgress = (_progress * 0.8).clamp(0, 1);

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

  void _calculateProgress() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final contentHeight = _contentKey.currentContext?.size?.height ?? 0;
      final screenHeight = MediaQuery.of(context).size.height;

      if (contentHeight <= screenHeight) {
        setState(() {
          _progress = 1;
          _secondaryProgress = 0.8;
          _animationController.forward();
        });
      } else {
        _updateProgress();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;
    if (arguments == null || arguments is! Lesson) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed(Routes.error);
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final lesson = arguments;
    _calculateProgress();

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
            onPressed: _progress < 1
                ? null
                : () {
                    Navigator.pushNamed(
                      context,
                      Routes.game,
                      arguments: {},
                    );
                  },
            style: TextButton.styleFrom(
              foregroundColor: _progress < 1 ? Colors.grey : Colors.blue,
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: ScaleTransition(
            scale: _animationController.drive(
              Tween(begin: 1.0, end: 1.5)
                  .chain(CurveTween(curve: Curves.elasticOut)),
            ),
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
                  lesson.title.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 24.0, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: _secondaryProgress,
                        backgroundColor: Colors.grey[300],
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Text("${(_secondaryProgress * 100).toInt()}%"),
                  ],
                ),
                const SizedBox(height: 20.0),
                Container(
                  key: _contentKey,
                  child: Text(lesson.content),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
