import 'dart:convert';

class TokenDto {
  TokenDto({
    required this.status,
    required this.token,
  });

  int status;
  String token;

  factory TokenDto.fromJson(Map<String, dynamic> json) => TokenDto(
        status: json["status"],
        token: json["data"],
      );
}
