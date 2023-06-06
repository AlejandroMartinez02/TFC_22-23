import '../../../utils/services/services.dart';
import '../../domain/entity/order_dto.dart';
import 'menu_client.dart';

class MenuService {
  static Future<String> getProductsByCategory(
      {required String category}) async {
    final token = await SecureStorageService.getToken();
    return await MenuClient.getProductsByCategory(
        token: token, category: category);
  }

  static Future<String> getCategories() async {
    final token = await SecureStorageService.getToken();
    return MenuClient.getCategories(token: token);
  }

  static Future<String> createOrder({required OrderDTO order}) async {
    final token = await SecureStorageService.getToken();
    return MenuClient.createOrder(order: order, token: token);
  }
}
