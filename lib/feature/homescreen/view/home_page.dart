import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tastify_food_app/core/constants/app_spacing.dart';
import 'package:tastify_food_app/core/constants/app_tex.dart';
import 'package:tastify_food_app/core/providers/meal_details_provider.dart';
import 'package:tastify_food_app/core/providers/meal_model_provider.dart';
import 'package:tastify_food_app/feature/homescreen/widgets/category_container.dart';
import 'package:tastify_food_app/feature/homescreen/widgets/circle_icon.dart';
import 'package:tastify_food_app/feature/homescreen/widgets/food_card.dart';
import 'package:tastify_food_app/feature/homescreen/widgets/home_widget.dart';
import 'package:tastify_food_app/feature/homescreen/widgets/offer_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateMeal = ref.watch(allfoodProvider);
    // Replace '0' with the appropriate key
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.caption('Hello .'),
            AppText.headingSmall(context, 'Delisas Agency'),
          ],
        ),

        actions: [
          CircleIcon(icon: Icons.search),
          AppSpacing.horizontalSmall,
          CircleIcon(icon: Icons.notifications),
          AppSpacing.horizontalSmall,
        ],
      ),
      body: stateMeal.when(
        data: (meal) {
          final details2 = ref.watch(foodDetailsProvider(meal[2].id));
          final details3 = ref.watch(foodDetailsProvider(meal[3].id));

          // Handle loading & error together
          if (details2.isLoading || details3.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (details2.hasError) {
            return Center(child: Text('Error: ${details2.error}'));
          }

          if (details3.hasError) {
            return Center(child: Text('Error: ${details3.error}'));
          }

          // If all good
          return HomeWidget(
            categories: [
              CategoryContainer(imageUrl: meal[0].imgUrl, label: 'Meat'),
              CategoryContainer(imageUrl: meal[1].imgUrl, label: 'Sushi'),
              CategoryContainer(imageUrl: meal[2].imgUrl, label: 'Fast Food'),
              CategoryContainer(imageUrl: meal[3].imgUrl, label: 'Noodles'),
            ],
            offerCardWidget: offerCard(),
            bestSellers: [
              FoodCard(
                imageUrl: meal[2].imgUrl,
                title: meal[2].title,
                price: details2.value!.price,
                calories:
                    details2.value != null
                        ? int.parse(details2.value!.calories)
                        : 0,
                time: 20,
              ),
              FoodCard(
                imageUrl: meal[3].imgUrl,
                title: meal[3].title,
                price: details3.value!.price,
                calories:
                    details3.value != null
                        ? int.parse(details3.value!.calories)
                        : 0,
                time: 15,
              ),
            ],
          );
        },

        error: (error, StackTrace) {
          return Center(child: Text(error.toString()));
        },
        loading: () {
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
