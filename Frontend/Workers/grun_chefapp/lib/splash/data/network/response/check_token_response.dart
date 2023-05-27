import 'dart:convert';

class CheckTokenResponse {
  CheckTokenResponse({
    required this.status,
    required this.token,
  });

  String status;
  String token;

  factory CheckTokenResponse.fromRawJson(String str) =>
      CheckTokenResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CheckTokenResponse.fromJson(Map<String, dynamic> json) =>
      CheckTokenResponse(
        status: json["status"].toString(),
        token: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": token,
      };
}
