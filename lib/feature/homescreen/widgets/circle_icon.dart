import 'package:flutter/material.dart';
import 'package:tastify_food_app/core/themes/app_colors.dart';

class CircleIcon extends StatelessWidget {
  const CircleIcon({super.key, required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColors.white,
      ),
      height: 50,
      width: 50,
      child: Icon(icon, size: 25, color: AppColors.black),
    );
  }
}
