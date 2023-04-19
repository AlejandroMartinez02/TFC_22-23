import 'dart:convert';

import 'package:grun_mobileapp/models/models.dart';
import 'package:grun_mobileapp/services/services.dart' show AuthService;

class AuthRepository {
  static Future Login(String? email, String? pass) async {
    final response = await AuthService.loginUser(email, pass);
    final decodedResponse = TokenDto.fromJson(json.decode(response));
//TODO: Save the token into User preferences

    print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
    if (decodedResponse.status == 200) return null;
    return decodedResponse.status.toString();
  }

  static Future register(CreateUserDto user) async {
    final response = await AuthService.registerUser(user.toJson());

    final decodedResponse = TokenDto.fromJson(json.decode(response));
    //TODO: Save the token into User preferences
    if (decodedResponse.status == 201) return null;
    return decodedResponse.status.toString();
  }
}
