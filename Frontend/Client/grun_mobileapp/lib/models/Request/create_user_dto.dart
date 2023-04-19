import 'dart:convert';

class CreateUserDto {
  CreateUserDto({
    required this.name,
    required this.lastname,
    required this.email,
    required this.phoneNumber,
    required this.rol,
    required this.password,
  });

  String name;
  String lastname;
  String email;
  String phoneNumber;
  String rol;
  String password;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "name": name,
        "lastname": lastname,
        "email": email,
        "phone_number": phoneNumber,
        "rol": rol,
        "password": password,
      };
}
