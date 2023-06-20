import 'dart:convert';

import '../../data/menu_repository.dart';
import '../../data/network/response/products_dto.dart';

class GetProductsByCategoryUseCase {
  static Future<List<ProductDTO>> getProductsByCategory(
      {required String category}) async {
    final response =
        await MenuRepository.getProductsByCategory(category: category);
    final Map<String, dynamic> productsMap = json.decode(response);
    final List<ProductDTO> products = [];
    productsMap['data']
        .forEach((product) => {products.add(ProductDTO.fromJson(product))});
    return products;
  }
}
