import 'package:flutter/material.dart';

extension ColorExtension on Color {
  Color withOpacity(double opacity) {
    return this.withOpacity(opacity);
  }
}

class AppColors {
  static Color background = Colors.white;
  static Color primary = const Color(0xFF1789FC);
  static Color appBar = const Color(0xFF1789FC).withOpacity(0.1);
  static Color secondary = const Color(0xFFEEF7FF);
  static Color label = const Color(0xFF213359);
  static Color subtitle = const Color(0xFF213359).withOpacity(0.5);

  static Color error = const Color(0xffff7466);
  static Color hint = const Color(0xFFD8DEE4);
}
