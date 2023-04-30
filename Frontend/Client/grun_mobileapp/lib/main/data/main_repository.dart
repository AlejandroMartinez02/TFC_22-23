import 'package:grun_mobileapp/main/data/network/main_service.dart';

class MainRespository {
  static Future<String> getProducts() async {
    return await MainService.getProducts();
  }

  static Future<String> getCategories() async {
    return await MainService.getCategories();
  }
}
