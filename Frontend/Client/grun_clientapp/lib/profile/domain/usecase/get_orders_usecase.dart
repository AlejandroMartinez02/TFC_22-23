import 'dart:convert';

import '../../data/network/response/order_dto.dart';
import '../../data/profile_repository.dart';

class GetOrdersUseCase {
  static Future<List<OrderDTO>> getOrders() async {
    final response = await ProfileRepository.getOrders();
    final Map<String, dynamic> orderMaps = json.decode(response);
    final List<OrderDTO> orders = [];
    orderMaps['data'].forEach((order) => orders.add(OrderDTO.fromJson(order)));
    return orders;
  }
}
