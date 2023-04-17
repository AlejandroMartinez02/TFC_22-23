// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

class Product {
  Product({
    this.id,
    required this.name,
    required this.ingredients,
    required this.category,
    required this.cost,
    required this.photo,
    required this.description,
  });

  String? id;
  String name;
  String ingredients;
  String category;
  double cost;
  String photo;
  String description;

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        name: json["name"],
        ingredients: json["ingredients"],
        category: json["category"],
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
