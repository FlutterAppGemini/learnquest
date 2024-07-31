import 'dart:async';

import 'package:flutter/material.dart';
import 'package:learnquest/feature/welcome/components/animated_page_dragger.dart';
import 'package:learnquest/feature/welcome/enum/slide_direction.dart';
import 'package:learnquest/feature/welcome/enum/update_type.dart';

class PageDragger extends StatefulWidget {
  final canDragLeftToRight;
  final canDragRightToLeft;

  final StreamController<SlideUpdate> slideUpdateStream;

  const PageDragger({
    super.key,
    this.canDragLeftToRight,
    this.canDragRightToLeft,
    required this.slideUpdateStream,
  });

  @override
  State<PageDragger> createState() => _PageDraggerState();
}

class _PageDraggerState extends State<PageDragger> {
  static const FULL_TRANSITION_PX = 300.0;

  late Offset? dragStart;
  late SlideDirection slideDirection;
  double slidePercent = 0.0;

  void onDragStart(DragStartDetails details) {
    dragStart = details.globalPosition;
  }

  void onDragUpdate(DragUpdateDetails details) {
    if (dragStart != null) {
      final newPosition = details.globalPosition;
      final dx = dragStart!.dx - newPosition.dx;

      if (dx > 0 && widget.canDragRightToLeft) {
        slideDirection = SlideDirection.rightToLeft;
      } else if (dx < 0 && widget.canDragLeftToRight) {
        slideDirection = SlideDirection.leftToRight;
      } else {
        slideDirection = SlideDirection.none;
      }

      if (slideDirection != SlideDirection.none) {
        slidePercent = (dx / FULL_TRANSITION_PX).abs().clamp(0.0, 1.0);
      } else {
        slidePercent = 0.0;
      }
      widget.slideUpdateStream
          .add(SlideUpdate(UpdateType.dragging, slideDirection, slidePercent));
    }
  }

  void onDragEnd(DragEndDetails details) {
    widget.slideUpdateStream.add(SlideUpdate(
      UpdateType.doneDragging,
      SlideDirection.none,
      0.0,
    ));

    dragStart = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: onDragStart,
      onHorizontalDragUpdate: onDragUpdate,
      onHorizontalDragEnd: onDragEnd,
    );
  }
}
