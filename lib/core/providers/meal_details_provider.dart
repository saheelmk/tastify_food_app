import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tastify_food_app/core/models/food_details.dart';
import 'package:tastify_food_app/core/providers/api_provider.dart';

// Create a FutureProvider for a list of MealModel
final foodDetailsProvider = FutureProvider.family<FoodDetails, int>((ref, id) {
  final api = ref.watch(apiServiceProvider);
  return api.fetchFoodDetails(id);
});
