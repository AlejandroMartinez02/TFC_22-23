import 'package:http/http.dart' as http;

import '../../../utils/constants.dart';
import '../../domain/entities/register_user_dto.dart';
import 'response/register_response.dart';

class RegisterClient {
  static const _baseUrl = Constants.httpAPI;

  static Future<RegisterResponse> register(RegisterUserDTO user) async {
    final url = Uri.http(_baseUrl, '/api/register');

    final response = await http.post(url,
        body: user.toRawJson(), headers: {'content-type': 'application/json'});
    return RegisterResponse.fromRawJson(response.body);
  }
}
