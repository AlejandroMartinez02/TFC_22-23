import 'package:grun_adminapp/users/domain/entities/user_dto.dart';

import '../../../utils/constants.dart';
import 'package:http/http.dart' as http;

class UserClient {
  static const _baseUrl = Constants.httpAPI;

  static Future<String> getUsers({required String token}) async {
    final url = Uri.http(_baseUrl, '/api/users/all');
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }

  static Future<String> updateUser(
      {required String token, required UserDTO updateUser}) async {
    final url = Uri.http(_baseUrl, '/api/users/');
    final response = await http.patch(url,
        body: updateUser.toJson(), headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }

  static Future<String> deleteUser(
      {required String token, required String id}) async {
    final url = Uri.http(_baseUrl, '/api/users/');
    final response = await http.delete(url, body: {
      "_id": id
    }, headers: {
      'Authorization': 'Bearer $token',
    });

    return response.body;
  }
}
