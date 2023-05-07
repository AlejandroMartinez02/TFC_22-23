import 'package:http/http.dart' as http;

import '../../../utils/constants.dart';

class ProfileClient {
  static String _baseUrl = Constants.httpAPI;

  static Future<String> getUser({required String token}) async {
    final uri = Uri.http(_baseUrl, '/api/users/');
    final response =
        await http.get(uri, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
}
