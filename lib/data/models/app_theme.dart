import 'package:flutter/material.dart';

abstract class AppThemeData {
  static const int primaryColorValue = 0xFF17f3ff;

  static const Map<int, Color> colorSwatch = {
    50: Color(0xFFE0F8FF),
    100: Color(0xFFB3E5FC),
    200: Color(0xFF81D4FA),
    300: Color(0xFF4FC3F7),
    400: Color(0xFF29B6F6),
    500: Color(primaryColorValue),
    600: Color(0xFF03A9F4),
    700: Color(0xFF039BE5),
    800: Color(0xFF0288D1),
    900: Color(0xFF0277BD),
  };
  static ThemeData appThemeData = ThemeData(
      // primarySwatch: const MaterialColor(primaryColorValue, colorSwatch),
      primaryColorDark: const MaterialColor(primaryColorValue, colorSwatch),
      brightness: Brightness.light);
}
