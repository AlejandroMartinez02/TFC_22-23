import 'dart:convert';

import '../../data/graphics_repository.dart';
import '../entities/product_graphics_dto.dart';

class GetBestSellingUseCase {
  static Future<List<ProductGraphicsDTO>> getBestSelling(
      {required int numOrders}) async {
    final response =
        await GraphicsRepository.getBestSellingProducts(numOrders: numOrders);
    print(response);
    List<ProductGraphicsDTO> products = [];
    final mapProducts = json.decode(response)['data'];
    mapProducts.forEach(
        (product) => products.add(ProductGraphicsDTO.fromJson(product)));
    return products;
  }
}
