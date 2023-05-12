import 'dart:convert';

import '../../data/menu_repository.dart';
import '../entity/order_dto.dart';

class CreateOrderUseCase {
  static Future<int> createOrder({required OrderDTO order}) async {
    final response = await MenuRepository.createOrder(order: order);
    print(json.decode(response)['status']);
    return json.decode(response)['status'];
  }
}
