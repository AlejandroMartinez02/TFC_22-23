// To parse this JSON data, do
//
//     final userDto = userDtoFromJson(jsonString);

import 'dart:convert';

class UserDTO {
  String id;
  String name;
  String lastname;
  String email;
  String phoneNumber;
  String address;

  UserDTO({
    required this.id,
    required this.name,
    required this.lastname,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });

  UserDTO copyWith({
    String? id,
    String? name,
    String? lastname,
    String? email,
    String? phoneNumber,
    String? address,
  }) =>
      UserDTO(
        id: id ?? this.id,
        name: name ?? this.name,
        lastname: lastname ?? this.lastname,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        address: address ?? this.address,
      );

  factory UserDTO.fromRawJson(String str) => UserDTO.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserDTO.fromJson(Map<String, dynamic> json) => UserDTO(
        id: json["_id"],
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "lastname": lastname,
        "email": email,
        "phone_number": phoneNumber,
        "address": address,
      };
}
