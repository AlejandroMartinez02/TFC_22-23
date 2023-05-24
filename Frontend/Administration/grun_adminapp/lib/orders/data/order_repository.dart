import 'network/order_service.dart';

class OrderRepository {
  static Future<String> getOrders() async {
    return await OrderService.getOrders();
  }

  static Future<String> deleteOrder({required String id}) async {
    return await OrderService.deleteOrder(id: id);
  }
}
