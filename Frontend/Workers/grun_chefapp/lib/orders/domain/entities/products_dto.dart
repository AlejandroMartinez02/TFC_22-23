import 'dart:convert';

class ProductDTO {
  ProductDTO({
    this.id,
    required this.name,
    required this.ingredients,
    required this.cost,
    required this.photo,
    required this.description,
  });

  String? id;
  String name;
  String ingredients;
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
        cost: json["cost"]?.toDouble(),
        photo: json["photo"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "ingredients": ingredients,
        "cost": cost,
        "photo": photo,
        "description": description,
      };
}
