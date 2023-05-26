import '../../../utils/constants.dart';
import 'package:http/http.dart' as http;

class GraphicsClient {
  static const _baseUrl = Constants.httpAPI;

  static Future<String> getBestSellingProducts(
      {required String token, required int numOrders}) async {
    final url = Uri.http(_baseUrl, '/api/orders/best-selling');
    final response = await http.get(url,
        headers: {'Authorization': 'Bearer $token', 'numorders': '$numOrders'});
    return response.body;
  }

  static Future<String> getLessPaidProducts(
      {required String token, required int numOrders}) async {
    final url = Uri.http(_baseUrl, '/api/orders/less-sold');
    final response = await http.get(url,
        headers: {'Authorization': 'Bearer $token', 'numorders': '$numOrders'});
    return response.body;
  }
}
