import 'dart:convert';

import '../../data/order_repository.dart';

class DeleteOrderUseCase {
  static Future<int> deleteOrder({required String id}) async {
    final response = await OrderRepository.deleteOrder(id: id);
    return json.decode(response)['status'];
  }
}
