import 'dart:convert';

class LoginResponse {
  LoginResponse({
    required this.status,
    required this.token,
  });

  String status;
  String token;

  factory LoginResponse.fromRawJson(String str) =>
      LoginResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"].toString(),
        token: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": token,
      };
}
