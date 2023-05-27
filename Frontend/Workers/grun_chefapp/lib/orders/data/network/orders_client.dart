import '../../../utils/constants.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/order_dto.dart';

class OrdersClient {
  static const _baseUrl = Constants.httpAPI;

  static Future<String> getOrders({required String token}) async {
    final url = Uri.http(_baseUrl, '/api/orders/inprocess');
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }

  static Future<String> updateOrder(
      {required String token, required OrderDTO updateOrder}) async {
    final url = Uri.http(_baseUrl, '/api/orders/');
    final response =
        await http.patch(url, body: updateOrder.toRawJson(), headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json; charset=UTF-8',
    });

    return response.body;
  }
}
