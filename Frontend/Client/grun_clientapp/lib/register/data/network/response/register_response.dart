import 'dart:convert';

class RegisterResponse {
  RegisterResponse({
    required this.status,
    required this.token,
  });

  String status;
  String token;

  factory RegisterResponse.fromRawJson(String str) =>
      RegisterResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        status: json["status"].toString(),
        token: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": token,
      };
}
