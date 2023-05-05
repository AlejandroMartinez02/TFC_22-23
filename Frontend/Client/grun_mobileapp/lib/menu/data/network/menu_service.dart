import 'package:grun_mobileapp/login/data/datastore/secure_storage_service.dart';
import 'package:grun_mobileapp/menu/data/network/menu_client.dart';

class MenuService {
  static Future<String> getProductsByCategory(
      {required String category}) async {
    final token = await SecureStorageService.getToken();
    return await MenuClient.getProductsByCategory(
        token: token, category: category);
  }
}
