// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodDetails _$FoodDetailsFromJson(Map<String, dynamic> json) => FoodDetails(
  place: json['place'] as String?,
  price: (json['pricePerServing'] as num?)?.toDouble() ?? 0.0,
  ingredients:
      json['extendedIngredients'] == null
          ? []
          : _ingredientsFromJson(json['extendedIngredients'] as List?),
  calories: extractCalories(json['summary'] as String),
);

Map<String, dynamic> _$FoodDetailsToJson(FoodDetails instance) =>
    <String, dynamic>{
      'place': instance.place,
      'pricePerServing': instance.price,
      'extendedIngredients': instance.ingredients,
      'summary': instance.calories,
    };
