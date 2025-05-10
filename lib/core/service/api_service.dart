import 'dart:convert';

import 'package:tastify_food_app/core/constants/constants.dart';
import 'package:tastify_food_app/core/models/food_app.dart';
import 'package:http/http.dart' as http;
import 'package:tastify_food_app/core/models/food_details.dart';

class ApiService {
  // returns list of food with minimal info
  Future<List<MealModel>> fetchAllFoods() async {
    final mealUrl =
        'https://api.spoonacular.com/recipes/complexSearch?query=pasta&apiKey=${Constants.apiKey}'; //requesting

    try {
      final response = await http.get(Uri.parse(mealUrl)); //response

      if (response.statusCode != 200) {
        print('Error: ${response.statusCode}, Body: ${response.body}');
        throw Exception('Failed to fetch data');
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;

      if (!data.containsKey('results') || data['results'] is! List) {
        throw Exception('Unexpected response format');
      }

      final mealsJson = data['results'] as List;
      final meals =
          mealsJson
              .map((json) => MealModel.fromJson(json))
              .toList(); //transform into List<MealModel>

      return meals;
    } catch (e) {
      print('Exception occurred: $e');
      rethrow;
    }
  }

  // returns extended ingredients, calories, price, etc.

  Future<FoodDetails> fetchFoodDetails(int id) async {
    final url =
        'https://api.spoonacular.com/recipes/$id/information?apiKey=${Constants.apiKey}';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) {
        print('Error: ${response.statusCode}, Body: ${response.body}');
        throw Exception('Failed to fetch the details of meals  data');
      }

      final data = jsonDecode(response.body) as Map<String, dynamic>;

      final foodDetails = FoodDetails.fromJson(data);

      return foodDetails;
    } catch (e) {
      print("Exception occurred: $e");
      rethrow;
    }
  }
}
