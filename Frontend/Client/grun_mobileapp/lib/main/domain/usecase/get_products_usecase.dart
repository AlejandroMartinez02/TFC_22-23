import 'dart:convert';

import '../../data/main_repository.dart';
import '../entity/products_dto.dart';

class GetProductsUseCase {
  static Future<List<ProductDTO>> getProducts() async {
    final response = await MainRepository.getProducts();
    final Map<String, dynamic> productsMap = json.decode(response);
    final List<ProductDTO> products = [];
    print(productsMap['data']);
    productsMap['data']
        .forEach((product) => products.add(ProductDTO.fromJson(product)));
    return products;
  }
}
