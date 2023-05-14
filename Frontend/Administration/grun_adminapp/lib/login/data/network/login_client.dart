import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../utils/constants.dart';
import '../../domain/entity/user_dto.dart';
import 'response/login_response.dart';

class LoginClient {
  static const _baseUrl = Constants.httpAPI;

  static Future<LoginResponse> login(UserDTO user) async {
    final url = Uri.http(_baseUrl, '/api/workerLogin');

    final response = await http.post(url,
        body: json.encode(user.toJson()),
        headers: {'content-type': 'application/json'});
    print(response.body);
    return LoginResponse.fromRawJson(response.body);
  }
}
