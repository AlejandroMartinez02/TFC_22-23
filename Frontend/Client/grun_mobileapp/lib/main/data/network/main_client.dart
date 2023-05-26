import 'package:http/http.dart' as http;
import 'package:grun_mobileapp/utils/utils.dart';

class MainClient {
  static const _baseUrl = Constants.httpAPI;
  static Future<String> getProducts({required String token}) async {
    final uri = Uri.http(_baseUrl, '/api/dishes/all');
    final response =
        await http.get(uri, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }

  static Future<String> getLessPaidProducts({required String token}) async {
    final uri = Uri.http(_baseUrl, '/api/orders/less-sold');
    final response = await http.get(uri,
        headers: {'Authorization': 'Bearer $token', 'numorders': '20'});
    return response.body;
  }

  static Future<String> getCategories({required String token}) async {
    final uri = Uri.http(_baseUrl, '/api/categories/all');
    final response =
        await http.get(uri, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
}
