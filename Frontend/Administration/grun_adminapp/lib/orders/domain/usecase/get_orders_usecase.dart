import 'dart:convert';

import '../../data/order_repository.dart';
import '../entities/order_dto.dart';

class GetAllOrdersUseCase {
  static Future<List<OrderDTO>> getOrders() async {
    final response = await OrderRepository.getOrders();
    final Map<String, dynamic> orderMaps = json.decode(response);
    final List<OrderDTO> orders = [];
    orderMaps['data'].forEach((order) => orders.add(OrderDTO.fromJson(order)));
    return orders;
  }
}
