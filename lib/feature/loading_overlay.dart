import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:learnquest/common/extension/custom_theme_extension.dart';

class LoadingOverlay extends StatefulWidget {
  final bool isLoading;

  const LoadingOverlay({super.key, required this.isLoading});

  @override
  State<LoadingOverlay> createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay> {
  bool _visible = false;

  @override
  void didUpdateWidget(covariant LoadingOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading && !_visible) {
      setState(() {
        _visible = true;
      });
    } else if (!widget.isLoading && _visible) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (!widget.isLoading) {
          setState(() {
            _visible = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _visible || widget.isLoading,
      child: AnimatedOpacity(
        opacity: widget.isLoading ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 20),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText('LearnQuest',
                          speed: const Duration(milliseconds: 300)),
                    ],
                    isRepeatingAnimation: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
