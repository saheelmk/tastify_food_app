// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_app.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealModel _$MealModelFromJson(Map<String, dynamic> json) => MealModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  imgUrl: json['image'] as String,
);

Map<String, dynamic> _$MealModelToJson(MealModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'image': instance.imgUrl,
};
