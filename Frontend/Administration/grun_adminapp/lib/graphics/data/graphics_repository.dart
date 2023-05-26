import 'network/graphics_service.dart';

class GraphicsRepository {
  static Future<String> getBestSellingProducts({required int numOrders}) async {
    return await GraphicsService.getBestSellingProducts(numOrders: numOrders);
  }

  static Future<String> getLessPaidProducts({required int numOrders}) async {
    return await GraphicsService.getLessPaidProducts(numOrders: numOrders);
  }
}
