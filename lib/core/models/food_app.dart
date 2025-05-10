import 'package:json_annotation/json_annotation.dart';

part 'food_app.g.dart';

@JsonSerializable()
class MealModel {
  final int id;
  final String title;
  @JsonKey(name: 'image')
  final String imgUrl;

  MealModel({required this.id, required this.title, required this.imgUrl});

  factory MealModel.fromJson(Map<String, dynamic> json) =>
      _$MealModelFromJson(json);
  Map<String, dynamic> toJson() => _$MealModelToJson(this);
}
