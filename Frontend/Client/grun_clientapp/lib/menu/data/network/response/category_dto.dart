import 'dart:convert';

class CategoryDTO {
  String id;
  String name;
  String description;
  String photo;

  CategoryDTO({
    required this.id,
    required this.name,
    required this.description,
    required this.photo,
  });

  CategoryDTO copyWith({
    String? id,
    String? name,
    String? description,
    String? photo,
  }) =>
      CategoryDTO(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        photo: photo ?? this.photo,
      );

  factory CategoryDTO.fromRawJson(String str) =>
      CategoryDTO.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryDTO.fromJson(Map<String, dynamic> json) => CategoryDTO(
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
