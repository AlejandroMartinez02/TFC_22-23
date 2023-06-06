import 'package:http/http.dart' as http;

import 'package:grun_mobileapp/utils/constants.dart';

class SplashClient {
  static const _baseUrl = Constants.httpAPI;
  static Future<String> checkToken(String token) async {
    final url = Uri.https(_baseUrl, '/api/checkToken');
    return (await http.get(url, headers: {'authorization': 'Bearer $token'}))
        .body;
  }
}
