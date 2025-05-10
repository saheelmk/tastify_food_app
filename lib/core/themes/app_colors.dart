import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static Color white = Color(0xFFFFFFFF);
  static Color black = Color(0xFF000000);

  static MaterialColor primary = MaterialColor(0xFF00AF66, {
    50: Color(0xFFE0F7EC),
    100: Color(0xFFB3EBD1),
    200: Color(0xFF80DEB3),
    300: Color(0xFF4DD196),
    400: Color(0xFF26C87F),
    500: Color(0xFF00AF66),
    600: Color(0xFF009A5B),
    700: Color(0xFF00824D),
    800: Color(0xFF006A3F),
    900: Color(0xFF004B2B),
  });

  static MaterialColor secondary = MaterialColor(0xFFEAF9F2, {
    50: Color(0xFFFFFFFF),
    100: Color(0xFFF5FCF8),
    200: Color(0xFFEBF9F1),
    300: Color(0xFFE3F5EB),
    400: Color(0xFFDFF3E8),
    500: Color(0xFFEAF9F2),
    600: Color(0xFFCFEADD),
    700: Color(0xFFB7DAC7),
    800: Color(0xFFA0CAB1),
    900: Color(0xFF7FAD93),
  });

  static MaterialColor grey = MaterialColor(0xFF707B81, {
    50: Color(0xFFF4F4F4),
    100: Color(0xFFE0E0E0),
    200: Color(0xFFBDBDBD),
    300: Color(0xFF9E9E9E),
    400: Color(0xFF818181),
    500: Color(0xFF707B81),
    600: Color(0xFF6A6A6A),
    700: Color(0xFF555555),
    800: Color(0xFF424242),
    900: Color(0xFF2B2B2B),
  });

  static MaterialColor errorColor = MaterialColor(0xFFF85656, {
    50: Color(0xFFFFEAEA),
    100: Color(0xFFFFC7C7),
    200: Color(0xFFFFA3A3),
    300: Color(0xFFFF8080),
    400: Color(0xFFFF6767),
    500: Color(0xFFF85656),
    600: Color(0xFFE14E4E),
    700: Color(0xFFCA4545),
    800: Color(0xFFB23B3B),
    900: Color(0xFF8A2C2C),
  });
}
