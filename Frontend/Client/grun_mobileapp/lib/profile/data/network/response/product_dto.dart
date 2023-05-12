import 'dart:convert';

class Product {
  String id;
  String name;
  String ingredients;
  String category;
  double cost;
  String photo;
  String description;

  Product({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.category,
    required this.cost,
    required this.photo,
    required this.description,
  });

  Product copyWith({
    String? id,
    String? name,
    String? ingredients,
    String? category,
    double? cost,
    String? photo,
    String? description,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        ingredients: ingredients ?? this.ingredients,
        category: category ?? this.category,
        cost: cost ?? this.cost,
        photo: photo ?? this.photo,
        description: description ?? this.description,
      );

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
