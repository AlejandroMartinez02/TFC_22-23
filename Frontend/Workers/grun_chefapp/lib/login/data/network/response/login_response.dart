import 'dart:convert';

import 'worker_dto.dart';

class LoginResponse {
  LoginResponse(
      {required this.status, required this.token, required this.worker});

  String status;
  String token;
  WorkerDTO worker;

  factory LoginResponse.fromRawJson(String str) =>
      LoginResponse.fromJson(json.decode(str));

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
      status: json["status"].toString(),
      token: json["data"],
      worker: WorkerDTO.fromJson(json["worker"]));
}
