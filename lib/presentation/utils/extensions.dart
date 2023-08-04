import 'package:flutter/material.dart';

extension ColorExtension on Color {
  Color darken([int percent = 50]) {
    assert(1 <= percent && percent <= 100);
    final factor = 1 - percent / 100;
    return Color.fromARGB(
      alpha,
      (red * factor).round(),
      (green * factor).round(),
      (blue * factor).round(),
    );
  }
}
