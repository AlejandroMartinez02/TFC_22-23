import 'package:grun_mobileapp/utils/utils.dart';
import 'package:http/http.dart' as http;

class MenuClient {
  static const String _baseUrl = Constants.httpAPI;

  static Future<String> getProductsByCategory(
      {required String token, required String category}) async {
    final uri = Uri.http(_baseUrl, '/api/dishes/bycategory');
    final response = await http.get(uri,
        headers: {'Authorization': 'Bearer $token', 'category': category});
    return response.body;
  }
}
