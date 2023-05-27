import 'dart:convert';

import '../../data/orders_repository.dart';
import '../entities/order_dto.dart';

class UpdateOrderUseCase {
  static Future<int> updateOrder({required OrderDTO updatedOrder}) async {
    final response =
        await OrderRepository.updateOrder(updateOrder: updatedOrder);
    return json.decode(response)['status'];
  }
}
