import 'dart:math';

import 'package:hive/hive.dart';

part 'global_demo_data_model.g.dart';

@HiveType(typeId: 0)
class FoodModel extends HiveObject {
  @HiveField(0)
  final String foodType;
  @HiveField(1)
  final String foodName;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final double foodPrice;
  @HiveField(4)
  final String imagePath;
  @HiveField(5)
  final double foodRate;
  @HiveField(6)
  final int numberOfReviewers;
  @HiveField(7)
  final int calories;
  @HiveField(8)
  final String? dishCountry;
  @HiveField(9)
  final String? dishCountryFlag;
  @HiveField(10)
  final List<String>? ingredientsImages;
  @HiveField(11)
  final List<String>? ingredientsNames;
  @HiveField(12)
  int stock;
  @HiveField(13)
  final String id;

  FoodModel({
    required this.foodName,
    required this.foodPrice,
    required this.foodRate,
    required this.description,
    required this.imagePath,
    required this.numberOfReviewers,
    required this.foodType,
    this.stock = 1,
    this.calories = 0,
    this.dishCountry,
    this.dishCountryFlag,
    this.ingredientsNames,
    this.ingredientsImages,
  }) : id = "$foodType$foodName";

  FoodModel copyWith({
    int? stock,
  }) {
    return FoodModel(
      foodName: foodName,
      foodPrice: foodPrice,
      foodRate: foodRate,
      description: description,
      imagePath: imagePath,
      calories: calories,
      dishCountry: dishCountry,
      dishCountryFlag: dishCountryFlag,
      ingredientsImages: ingredientsImages,
      ingredientsNames: ingredientsNames,
      numberOfReviewers: numberOfReviewers,
      foodType: foodType,
      stock: stock ?? this.stock,
    );
  }

  Map<String, dynamic> fromModel({required FoodModel item}) {
    return {
      "reviewersNumber": item.numberOfReviewers,
      "ingImages": item.ingredientsImages,
      "ingNames": item.ingredientsNames,
      "description": item.description,
      "flag": item.dishCountryFlag,
      "itemPrice": item.foodPrice,
      "country": item.dishCountry,
      "imagePath": item.imagePath,
      "itemRate": item.foodRate,
      "itemName": item.foodName,
      "calories": item.calories,
      "type": item.foodType,
      "stock": item.stock,
      "id": item.id,
    };
  }

  factory FoodModel.fromSnapshots({required Map<String, dynamic> snapshot}) {
    final List<String>? ingImages =
        (snapshot["ingImages"] as List?)?.cast<String>();

    final List<String>? ingNames = (snapshot["ingNames"] as List<dynamic>?)
        ?.map((item) => item.toString())
        .toList();

    return FoodModel(
      numberOfReviewers: snapshot["reviewersNumber"] as int,
      ingredientsImages: ingImages,
      ingredientsNames: ingNames,
      /* ingredientsImages: snapshot["ingImages"] as List<String>?,
      ingredientsNames: snapshot["ingNames"] as List<String>?, */
      description: snapshot["description"] as String,
      dishCountryFlag: snapshot["flag"] as String?,
      dishCountry: snapshot["country"] as String?,
      foodPrice: snapshot["itemPrice"] as double,
      imagePath: snapshot["imagePath"] as String,
      foodRate: snapshot["itemRate"] as double,
      foodName: snapshot["itemName"] as String,
      calories: snapshot["calories"] as int,
      foodType: snapshot["type"] as String,
      stock: snapshot["stock"] as int,
    );
  }
}
