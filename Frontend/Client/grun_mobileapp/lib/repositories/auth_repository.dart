import 'dart:convert';

import 'package:grun_mobileapp/models/models.dart';
import 'package:grun_mobileapp/services/services.dart' show AuthService;
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    show FlutterSecureStorage;

class AuthRepository {
  static const _storage = FlutterSecureStorage();

  static Future login(String? email, String? pass) async {
    final response = await AuthService.loginUser(email, pass);

    final decodedResponse = TokenDto.fromJson(json.decode(response));

    if (decodedResponse.status == 200) {
      await _storage.write(key: 'token', value: decodedResponse.token);

      return null;
    }
    return decodedResponse.status.toString();
  }

  static Future register(CreateUserDto user) async {
    final response = await AuthService.registerUser(user.toJson());

    final decodedResponse = TokenDto.fromJson(json.decode(response));

    if (decodedResponse.status == 201) {
      await _storage.write(key: 'token', value: decodedResponse.token);
      return null;
    }
    return decodedResponse.status.toString();
  }

  static Future logOut() async {
    _storage.delete(key: 'token');
  }

  static Future<String> readToken() async {
    return await _storage.read(key: 'token') ?? '';
  }
}
