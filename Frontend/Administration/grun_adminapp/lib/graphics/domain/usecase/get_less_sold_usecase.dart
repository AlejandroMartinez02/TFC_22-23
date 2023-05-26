import 'dart:convert';

import '../../data/graphics_repository.dart';
import '../entities/product_graphics_dto.dart';

class GetLessSoldUseCase {
  static Future<List<ProductGraphicsDTO>> getLessPaidProducts(
      {required int numOrders}) async {
    final response =
        await GraphicsRepository.getLessPaidProducts(numOrders: numOrders);
    List<ProductGraphicsDTO> products = [];
    final mapProducts = json.decode(response)['data'];
    mapProducts.forEach(
        (product) => products.add(ProductGraphicsDTO.fromJson(product)));
    return products;
  }
}
