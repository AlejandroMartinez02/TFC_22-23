import 'dart:convert';

class RegisterUserDTO {
  RegisterUserDTO({
    required this.name,
    required this.lastname,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.password,
  });

  String name;
  String lastname;
  String email;
  String phoneNumber;
  String address;
  String password;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "name": name,
        "lastname": lastname,
        "email": email,
        "phone_number": phoneNumber,
        "address": address,
        "password": password,
      };
}
