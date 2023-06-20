import '../../../utils/services/services.dart';
import 'main_client.dart';

class MainService {
  static Future<String> getProducts() async {
    final token = await SecureStorageService.getToken();
    return await MainClient.getProducts(token: token);
  }

  static Future<String> getCategories() async {
    final token = await SecureStorageService.getToken();
    return await MainClient.getCategories(token: token);
  }

  static Future<String> getLessPaidProducts() async {
    final token = await SecureStorageService.getToken();
    return await MainClient.getLessPaidProducts(token: token);
  }
}
