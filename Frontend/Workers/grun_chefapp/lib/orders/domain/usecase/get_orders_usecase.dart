import 'dart:convert';

import '../../data/orders_repository.dart';
import '../entities/order_dto.dart';

class GetOrdersUseCase {
  static Future<List<OrderDTO>> getOrders() async {
    final response = await OrderRepository.getOrders();
    List<OrderDTO> orders = [];
    final mapOrders = json.decode(response)['data'];
    mapOrders.forEach((order) => orders.add(OrderDTO.fromJson(order)));
    return orders;
  }
}
