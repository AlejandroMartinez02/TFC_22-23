import '../../../utils/constants.dart';
import 'package:http/http.dart' as http;

class OrderClient {
  static const String _baseUrl = Constants.httpAPI;

  static Future<String> getOrders({required String token}) async {
    final uri = Uri.http(_baseUrl, '/api/orders/allAdmin');
    final response =
        await http.get(uri, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }

  static Future<String> deleteOrder(
      {required String id, required String token}) async {
    final url = Uri.http(_baseUrl, '/api/orders');
    final response = await http.delete(url,
        body: {"_id": id}, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
}
