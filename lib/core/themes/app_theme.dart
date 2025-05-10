import 'package:flutter/material.dart';
import 'package:tastify_food_app/core/themes/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.primary,
    primaryColorLight: AppColors.grey.shade50,
    textTheme: TextTheme(),
    colorScheme: ColorScheme.light().copyWith(
      surface: AppColors.white,
      onSurface: AppColors.black,
    ),
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.black,
    primaryColor: AppColors.primary,
    primaryColorLight: AppColors.grey.shade900,
    colorScheme: ColorScheme.dark().copyWith(
      surface: AppColors.grey.shade900,
      onSurface: AppColors.white,
    ),
  );
}
