import 'package:grun_mobileapp/login/data/datastore/secure_storage_service.dart';
import 'package:grun_mobileapp/main/data/network/main_client.dart';

class MainService {
  static Future<String> getProducts() async {
    final token = await SecureStorageService.getToken();
    return MainClient.getProducts(token: token);
  }

  static Future<String> getCategories() async {
    final token = await SecureStorageService.getToken();
    return MainClient.getCategories(token: token);
  }
}
