import '../../../utils/services/secure_storage_service.dart';
import '../../domain/entities/order_dto.dart';
import 'orders_client.dart';

class OrdersService {
  static Future<String> getOrders() async {
    final token = await SecureStorageService.getToken();
    return await OrdersClient.getOrders(token: token);
  }

  static Future<String> updateOrder({required OrderDTO updateOrder}) async {
    final token = await SecureStorageService.getToken();
    return await OrdersClient.updateOrder(
        token: token, updateOrder: updateOrder);
  }
}
