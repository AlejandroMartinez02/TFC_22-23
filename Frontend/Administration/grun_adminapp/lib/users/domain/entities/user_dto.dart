import 'dart:convert';

class UserDTO {
  String id;
  String name;
  String lastname;
  String email;
  String address;
  String phoneNumber;

  UserDTO({
    required this.id,
    required this.name,
    required this.lastname,
    required this.email,
    required this.address,
    required this.phoneNumber,
  });

  UserDTO copyWith({
    String? id,
    String? name,
    String? lastname,
    String? email,
    String? address,
    String? phoneNumber,
  }) =>
      UserDTO(
        id: id ?? this.id,
        name: name ?? this.name,
        lastname: lastname ?? this.lastname,
        email: email ?? this.email,
        address: address ?? this.address,
        phoneNumber: phoneNumber ?? this.phoneNumber,
      );

  factory UserDTO.fromRawJson(String str) => UserDTO.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserDTO.fromJson(Map<String, dynamic> json) => UserDTO(
        id: json["_id"],
        name: json["name"],
        lastname: json["lastname"],
        email: json["email"],
        address: json["address"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "lastname": lastname,
        "email": email,
        "address": address,
        "phone_number": phoneNumber,
      };

  bool equals(UserDTO toCompare) {
    return address == toCompare.address &&
            email == toCompare.email &&
            lastname == toCompare.lastname &&
            name == toCompare.name &&
            phoneNumber == toCompare.phoneNumber
        ? true
        : false;
  }
}
