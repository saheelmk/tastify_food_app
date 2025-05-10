import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tastify_food_app/core/models/food_app.dart';
import 'package:tastify_food_app/core/providers/api_provider.dart';

// Create a FutureProvider for a list of MealModel
final allfoodProvider = FutureProvider<List<MealModel>>((ref) async {
  final api = ref.watch(apiServiceProvider);
  return api.fetchAllFoods();
});
