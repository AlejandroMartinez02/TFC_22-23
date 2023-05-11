import 'package:grun_mobileapp/login/data/datastore/secure_storage_service.dart';
import 'package:grun_mobileapp/menu/data/network/menu_client.dart';

import '../../domain/entity/order_dto.dart';

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
