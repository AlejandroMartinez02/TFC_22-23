import '../../../utils/services/secure_storage_service.dart';
import 'graphics_client.dart';

class GraphicsService {
  static Future<String> getBestSellingProducts({required int numOrders}) async {
    final token = await SecureStorageService.getToken();
    return await GraphicsClient.getBestSellingProducts(
        numOrders: numOrders, token: token);
  }

  static Future<String> getLessPaidProducts({required int numOrders}) async {
    final token = await SecureStorageService.getToken();
    return await GraphicsClient.getLessPaidProducts(
        token: token, numOrders: numOrders);
  }
}
