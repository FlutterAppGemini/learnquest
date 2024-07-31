import 'package:flutter/material.dart';
import 'package:learnquest/feature/welcome/components/circle_reveal_clipper.dart';

class PageReveal extends StatelessWidget {
  final double revealPercent;
  final Widget child;

  const PageReveal(
      {super.key, required this.revealPercent, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      clipper: CircleRevealClipper(revealPercent),
      child: child,
    );
  }
}
