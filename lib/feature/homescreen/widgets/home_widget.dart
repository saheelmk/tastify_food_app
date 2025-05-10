import 'package:flutter/material.dart';
import 'package:tastify_food_app/core/constants/app_spacing.dart';
import 'package:tastify_food_app/core/constants/app_tex.dart';
import 'package:tastify_food_app/core/themes/app_colors.dart';
import 'package:tastify_food_app/feature/homescreen/widgets/category_container.dart';
import 'package:tastify_food_app/feature/homescreen/widgets/food_card.dart';

class HomeWidget extends StatelessWidget {
  final List<CategoryContainer> categories;
  final Widget offerCardWidget;
  final List<FoodCard> bestSellers;

  const HomeWidget({
    super.key,
    required this.categories,
    required this.offerCardWidget,
    required this.bestSellers,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        AppSpacing.verticalMedium,
        // Categories
        Row(
          children: [
            AppSpacing.horizontalSmall,
            ...categories.expand(
              (category) => [category, AppSpacing.horizontalMedium],
            ),
          ],
        ),

        AppSpacing.verticalMedium,
        // Offer card
        offerCardWidget,
        AppSpacing.verticalMedium,

        // Best Seller
        ListTile(
          title: AppText.heading(context, "Best Sellers"),
          trailing: AppText.headingSmall(
            context,
            'See All',
            color: AppColors.primary,
          ),
        ),

        AppSpacing.verticalSmall,

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: bestSellers,
        ),
      ],
    );
  }
}
