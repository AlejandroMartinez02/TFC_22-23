import '../domain/entities/order_dto.dart';
import 'network/orders_service.dart';

class OrderRepository {
  static Future<String> getOrders() async {
    return await OrdersService.getOrders();
  }

  static Future<String> updateOrder({required OrderDTO updateOrder}) async {
    return await OrdersService.updateOrder(updateOrder: updateOrder);
  }
}
