import '../../../utils/services/secure_storage_service.dart';
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
    return await MenuClient.getCategories(token: token);
  }

  static Future<String> createOrder({required OrderDTO order}) async {
    final token = await SecureStorageService.getToken();
    return await MenuClient.createOrder(order: order, token: token);
  }

  static Future<String> getTables() async {
    final token = await SecureStorageService.getToken();
    return await MenuClient.getTables(token: token);
  }

  static Future<String> getWorker() async {
    final token = await SecureStorageService.getToken();
    return await MenuClient.getWorker(token: token);
  }
}
