// To parse this JSON data, do
//
//     final productGraphicsDto = productGraphicsDtoFromJson(jsonString);

import 'dart:convert';

class ProductGraphicsDTO {
  Product product;
  int count;

  ProductGraphicsDTO({
    required this.product,
    required this.count,
  });

  ProductGraphicsDTO copyWith({
    Product? product,
    int? count,
  }) =>
      ProductGraphicsDTO(
        product: product ?? this.product,
        count: count ?? this.count,
      );

  factory ProductGraphicsDTO.fromRawJson(String str) =>
      ProductGraphicsDTO.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductGraphicsDTO.fromJson(Map<String, dynamic> json) =>
      ProductGraphicsDTO(
        product: Product.fromJson(json["_id"]),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "_id": product.toJson(),
        "count": count,
      };
}

class Product {
  String id;
  String name;
  String ingredients;
  Category category;
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
    Category? category,
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
        category: Category.fromJson(json["category"]),
        cost: json["cost"]?.toDouble(),
        photo: json["photo"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "ingredients": ingredients,
        "category": category.toJson(),
        "cost": cost,
        "photo": photo,
        "description": description,
      };
}

class Category {
  String id;
  String name;
  String description;
  String photo;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.photo,
  });

  Category copyWith({
    String? id,
    String? name,
    String? description,
    String? photo,
  }) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        photo: photo ?? this.photo,
      );

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "photo": photo,
      };
}
