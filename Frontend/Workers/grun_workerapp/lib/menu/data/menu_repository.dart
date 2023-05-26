import '../domain/entity/order_dto.dart';
import 'network/menu_service.dart';

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

  static Future<String> getTables() async {
    return await MenuService.getTables();
  }
}
