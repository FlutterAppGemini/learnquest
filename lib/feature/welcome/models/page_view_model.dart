import 'package:flutter/material.dart';

class PageViewModel {
  final Color color;
  final String heroAssetPath;
  final String title;
  final String body;
  final Icon icon;

  PageViewModel(
    this.color,
    this.heroAssetPath,
    this.title,
    this.body,
    this.icon,
  );
}
