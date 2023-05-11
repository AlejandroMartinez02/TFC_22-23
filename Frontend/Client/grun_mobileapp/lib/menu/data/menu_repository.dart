import 'package:grun_mobileapp/menu/data/network/menu_service.dart';

import '../domain/entity/order_dto.dart';

class MenuRepository {
  static Future<String> getProductsByCategory(
      {required String category}) async {
    return await MenuService.getProductsByCategory(category: category);
  }

  static Future<String> getCategories() async {
    return await MenuService.getCategories();
  }

  static Future<String> createOrder({required OrderDTO order}) async {
    return await MenuService.createOrder(order: order);
  }
}
