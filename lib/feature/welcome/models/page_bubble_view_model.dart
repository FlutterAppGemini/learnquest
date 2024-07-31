import 'package:flutter/material.dart';

class PageBubbleViewModel {
  final Icon icon;
  final Color color;
  final bool isHollow;
  final double activePercent;

  PageBubbleViewModel(
    this.icon,
    this.color,
    this.isHollow,
    this.activePercent,
  );
}
