import 'package:json_annotation/json_annotation.dart';

part 'food_details.g.dart';

@JsonSerializable()
class FoodDetails {
  final String? place;

  @JsonKey(name: 'pricePerServing', defaultValue: 0.0)
  final double price;

  @JsonKey(
    name: 'extendedIngredients',
    fromJson: _ingredientsFromJson,
    defaultValue: [],
  )
  final List<String> ingredients;

  @JsonKey(name: 'summary', fromJson: extractCalories)
  final String calories;

  const FoodDetails({
    this.place,
    required this.price,
    required this.ingredients,
    required this.calories,
  });

  factory FoodDetails.fromJson(Map<String, dynamic> json) =>
      _$FoodDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$FoodDetailsToJson(this);
}

// Custom fromJson function for ingredients
List<String> _ingredientsFromJson(List<dynamic>? json) {
  if (json == null) return [];

  return json
      .map((item) => item['original'] as String?)
      .where((original) => original != null)
      .map((original) => original!)
      .toList();
}

// Extracts calories from summary string like "This has 230 calories"
String extractCalories(String summary) {
  final regex = RegExp(r'(\d+)\s*calories', caseSensitive: false);
  final match = regex.firstMatch(summary);
  return match != null ? match.group(1)! : '0';
}
