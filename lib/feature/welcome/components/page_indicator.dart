import 'package:flutter/material.dart';
import 'package:learnquest/feature/welcome/components/page_bubble.dart';
import 'package:learnquest/feature/welcome/enum/slide_direction.dart';
import 'package:learnquest/feature/welcome/models/page_bubble_view_model.dart';
import 'package:learnquest/feature/welcome/models/page_indicator_view_model.dart';

class PagerIndicator extends StatelessWidget {
  final PagerIndicatorViewModel viewModel;

  const PagerIndicator({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    List<PageBubble> bubbles = [];
    for (var i = 0; i < viewModel.pages.length; ++i) {
      final page = viewModel.pages[i];

      double percentActive;

      if (i == viewModel.activeIndex) {
        percentActive = 1.0 - viewModel.slidePercent;
      } else if (i == viewModel.activeIndex - 1 &&
          viewModel.slideDirection == SlideDirection.leftToRight) {
        percentActive = viewModel.slidePercent;
      } else if (i == viewModel.activeIndex + 1 &&
          viewModel.slideDirection == SlideDirection.rightToLeft) {
        percentActive = viewModel.slidePercent;
      } else {
        percentActive = 0.0;
      }

      bool isHollow = i > viewModel.activeIndex ||
          (i == viewModel.activeIndex &&
              viewModel.slideDirection == SlideDirection.leftToRight);

      bubbles.add(
        PageBubble(
          viewModel: PageBubbleViewModel(
            page.icon,
            page.color,
            isHollow,
            percentActive,
          ),
        ),
      );
    }

    const bubbleWidht = 55.0;
    final baseTranslation =
        ((viewModel.pages.length * bubbleWidht) / 2) - (bubbleWidht / 2);
    var translation = baseTranslation - (viewModel.activeIndex * bubbleWidht);

    if (viewModel.slideDirection == SlideDirection.leftToRight) {
      translation += bubbleWidht * viewModel.slidePercent;
    } else if (viewModel.slideDirection == SlideDirection.rightToLeft) {
      translation -= bubbleWidht * viewModel.slidePercent;
    }

    return Column(
      children: <Widget>[
        Expanded(child: Container()),
        Transform(
          transform: Matrix4.translationValues(translation, 0.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: bubbles,
          ),
        ),
      ],
    );
  }
}
