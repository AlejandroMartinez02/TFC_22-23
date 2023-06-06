import 'package:http/http.dart' as http;

import '../../../utils/constants.dart';

class SplashClient {
  static const _baseUrl = Constants.httpAPI;
  static Future<String> checkToken(String token) async {
    final url = Uri.http(_baseUrl, '/api/checkToken');
    return (await http.get(url, headers: {'authorization': 'Bearer $token'}))
        .body;
  }
}
