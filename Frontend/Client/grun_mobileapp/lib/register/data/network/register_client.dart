import 'package:grun_mobileapp/register/data/network/response/register_response.dart';
import 'package:grun_mobileapp/register/domain/entities/register_user_dto.dart';
import 'package:grun_mobileapp/utils/utils.dart';
import 'package:http/http.dart' as http;

class RegisterClient {
  static const _baseUrl = Constants.httpAPI;

  static Future<RegisterResponse> register(RegisterUserDTO user) async {
    final url = Uri.http(_baseUrl, '/api/register');

    final response = await http.post(url,
        body: user.toJson(), headers: {'content-type': 'application/json'});
    return RegisterResponse.fromRawJson(response.body);
  }
}
