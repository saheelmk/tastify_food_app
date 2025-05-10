import 'package:flutter/material.dart';
import 'package:tastify_food_app/core/constants/app_tex.dart';
import 'package:tastify_food_app/core/themes/app_colors.dart';

class CategoryContainer extends StatelessWidget {
  final String imageUrl;
  final String label;

  const CategoryContainer({
    super.key,
    required this.imageUrl,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      height: 100,
      width: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: 50,
              width: 50,
            ),
          ),
          AppText.bodySmall(context, label),
        ],
      ),
    );
  }
}
