import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:learnquest/feature/welcome/enum/transition_goal.dart';
import 'package:learnquest/feature/welcome/enum/update_type.dart';

class AnimatedPageDragger {
  static const PERCENT_PER_MILLISECOND = 0.005;

  final slideDirection;
  final transitionGoal;

  AnimationController? completionAnimationController;

  AnimatedPageDragger({
    this.slideDirection,
    this.transitionGoal,
    slidePercent,
    required StreamController<SlideUpdate> slideUpdateStream,
    required TickerProvider vsync,
  }) {
    final startSlidePercent = slidePercent;
    double endSlidePercent;
    Duration duration;

    if (transitionGoal == TransitionGoal.open) {
      endSlidePercent = 1.0;

      final slideRemaining = 1.0 - slidePercent;

      duration = Duration(
          milliseconds: (slideRemaining / PERCENT_PER_MILLISECOND).round());
    } else {
      endSlidePercent = 0.0;
      duration = Duration(
          milliseconds: (slidePercent / PERCENT_PER_MILLISECOND).round());
    }

    completionAnimationController =
        AnimationController(duration: duration, vsync: vsync)
          ..addListener(() {
            slidePercent = lerpDouble(startSlidePercent, endSlidePercent,
                completionAnimationController!.value);

            slideUpdateStream.add(SlideUpdate(
              UpdateType.animating,
              slideDirection,
              slidePercent,
            ));
          })
          ..addStatusListener((AnimationStatus status) {
            if (status == AnimationStatus.completed) {
              slideUpdateStream.add(SlideUpdate(
                UpdateType.doneAnimating,
                slideDirection,
                endSlidePercent,
              ));
            }
          });
  }

  void run() {
    completionAnimationController!.forward(from: 0.0);
  }

  void dispose() {
    completionAnimationController!.dispose();
  }
}

class SlideUpdate {
  final updateType;
  final direction;
  final slidePercent;

  SlideUpdate(this.updateType, this.direction, this.slidePercent);
}
