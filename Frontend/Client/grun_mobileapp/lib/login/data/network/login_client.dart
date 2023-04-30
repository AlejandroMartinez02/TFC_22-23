import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:grun_mobileapp/login/data/network/response/login_response.dart';
import 'package:grun_mobileapp/login/domain/entity/user_dto.dart';
import 'package:grun_mobileapp/utils/utils.dart' show Constants;

class LoginClient {
  static const _baseUrl = Constants.httpAPI;

  static Future<LoginResponse> login(UserDTO user) async {
    final url = Uri.http(_baseUrl, '/api/login');

    final response = await http.post(url,
        body: json.encode(user.toJson()),
        headers: {'content-type': 'application/json'});
    return LoginResponse.fromRawJson(response.body);
  }
}
