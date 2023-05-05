import 'package:grun_mobileapp/menu/data/network/menu_service.dart';

class MenuRepository {
  static Future<String> getProductsByCategory(
      {required String category}) async {
    return await MenuService.getProductsByCategory(category: category);
  }
}
