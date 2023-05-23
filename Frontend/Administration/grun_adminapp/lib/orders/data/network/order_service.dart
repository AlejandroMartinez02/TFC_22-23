import '../../../utils/services/secure_storage_service.dart';
import 'order_client.dart';

class OrderService {
  static Future<String> getOrders() async {
    final token = await SecureStorageService.getToken();
    return await OrderClient.getOrders(token: token);
  }

  static Future<String> deleteOrder({required String id}) async {
    final token = await SecureStorageService.getToken();
    return await OrderClient.deleteOrder(id: id, token: token);
  }
}
