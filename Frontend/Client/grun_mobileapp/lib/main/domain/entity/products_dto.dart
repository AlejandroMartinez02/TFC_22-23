import 'dart:convert';

import 'package:grun_mobileapp/main/domain/entity/category_dto.dart';

class ProductDTO {
  ProductDTO({
    this.id,
    required this.name,
    required this.ingredients,
    required this.category,
    required this.cost,
    required this.photo,
    required this.description,
  });

  String? heroId;
  String? id;
  String name;
  String ingredients;
  CategoryDTO category;
  double cost;
  String photo;
  String description;

  factory ProductDTO.fromRawJson(String str) =>
      ProductDTO.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductDTO.fromJson(Map<String, dynamic> json) => ProductDTO(
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
        "category": category,
        "cost": cost,
        "photo": photo,
        "description": description,
      };
}
