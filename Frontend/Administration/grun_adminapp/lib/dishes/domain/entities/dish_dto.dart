import 'dart:convert';

import 'category_dto.dart';

class DishDTO {
  String id;
  String name;
  String ingredients;
  CategoryDTO category;
  double cost;
  String? photo;
  String description;

  DishDTO({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.category,
    required this.cost,
    required this.photo,
    required this.description,
  });

  DishDTO copyWith({
    String? id,
    String? name,
    String? ingredients,
    CategoryDTO? category,
    double? cost,
    String? photo,
    String? description,
  }) =>
      DishDTO(
        id: id ?? this.id,
        name: name ?? this.name,
        ingredients: ingredients ?? this.ingredients,
        category: category ?? this.category,
        cost: cost ?? this.cost,
        photo: photo ?? this.photo,
        description: description ?? this.description,
      );

  factory DishDTO.fromRawJson(String str) => DishDTO.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DishDTO.fromJson(Map<String, dynamic> json) => DishDTO(
        id: json["_id"],
        name: json["name"],
        ingredients: json["ingredients"],
        category: CategoryDTO.fromJson(json["category"]),
        cost: json["cost"]?.toDouble(),
        photo: json["photo"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "ingredients": ingredients,
        "category": category.id,
        "cost": cost.toString(),
        "photo": photo,
        "description": description,
      };

  bool equals(DishDTO toCompare) {
    return ingredients == toCompare.ingredients &&
            category.equals(toCompare.category) &&
            cost == toCompare.cost &&
            name == toCompare.name &&
            photo == toCompare.photo &&
            description == toCompare.description
        ? true
        : false;
  }
}
