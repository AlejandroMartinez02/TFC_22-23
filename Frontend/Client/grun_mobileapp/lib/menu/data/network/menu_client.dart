import 'package:grun_mobileapp/utils/utils.dart';
import 'package:http/http.dart' as http;

import '../../domain/entity/order_dto.dart';

class MenuClient {
  static const String _baseUrl = Constants.httpAPI;

  static Future<String> getProductsByCategory(
      {required String token, required String category}) async {
    final uri = Uri.https(_baseUrl, '/api/dishes/bycategory');
    final response = await http.get(uri,
        headers: {'Authorization': 'Bearer $token', 'category': category});
    return response.body;
  }

  static Future<String> getCategories({required String token}) async {
    final uri = Uri.https(_baseUrl, '/api/categories/all');
    final response =
        await http.get(uri, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }

  static Future<String> createOrder(
      {required OrderDTO order, required String token}) async {
    final uri = Uri.https(_baseUrl, '/api/orders/');
    final response = await http.post(uri, body: order.toRawJson(), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    });
    return response.body;
  }
}
